class IndicesController < ApplicationController

	def index
		@index = Index.new
 	end

 	#Call the crawler function
 	def create
 		startjobs = WorkingDyno.new
 		company = params[:index][:company].downcase
 		country = params[:index][:country].downcase
 		url = params[:index][:url]

 		mine_me = MineMe.new
	 	unless User.where(:url => url.downcase).exists?
	 	the_user = mine_me.mining url
	 	end
	 	id = User.where(:url => url.downcase).pluck(:_id)[0].to_s

 		startjobs.delay.queueJob company, country, url
	 	#redirect_to :controller => 'similarities', :action => 'thankYouQueueOutput'
	 	redirect_to provideemail_url(company, country, id)

 		#unless User.where(:url => url.downcase).exists?
 		#the_user = mine_me.mining url
 		#end

 		#id = User.where(:url => url.downcase).pluck(:_id)[0].to_s

 		#company_exists = crawler.search company, country
 		#if(company_exists)
 		#	@company = company
 		#	@country = country
 		#	@id = id

 		#	render :confirm_search #this is the same as "indices"
 		#else
 		#	redirect_to :controller => 'static_pages', :action => 'about'
		#	crawler.delay.crawl company, country
			#redirect_to get_match_url(company, id)
 		#end

 		#redirect_to get_match_url(company, id)
 		#Should not redirect,  queue similarities.output(company, id), create that page and invoke sendEmailFunction(@email, @id)
 	end

 	class WorkingDyno
	 	def queueJob company, country, url
	 		crawler = WebCrawler.new
	 		crawler.crawl company, country
	 	end
	end

 	def accept_crawl
		company = params[:company]
 		country = params[:country]
 		id = params[:id]
 		crawler = WebCrawler.new
 		crawler.crawl company, country
		redirect_to get_match_url(company, id)
	end

	class MineMe
		require_relative 'MineMe'

		def mining url
			the_user = mine_me_alg(url)

			the_user.each do |key|
					#Create the user if Doesn't exist
					user_name = the_user[0]
					user_url = url

					db_user = User.find_by name: user_name.downcase
					if(!db_user.present?) #create the entity
						db_user = User.new(:name => user_name, :url => user_url)
						db_user.save
					end

					#Create the company if Doesn't exist
					db_company = Company.find_by name: the_user[2][0].downcase
					if(!db_company.present?) #create the entity
						db_company = Company.new(:name => the_user[2][0])
						db_company.save
					end

					#Create the skills if Doesn't exist, and add the skills to the user
					my_skills = db_user.skills
					the_user[1].each do |skill|
						db_skill = Skill.find_by name: skill.downcase
						if(!db_skill.present?) #create the entity
							db_skill = Skill.new(:name => skill)
							db_skill.save
						end

						unless my_skills.include? db_skill
					      db_user.skills << db_skill
					      db_user.save
					    end
					end

					#Add the company to the user
					db_user.company = db_company
				    db_user.save
				end
		end
	end

 	class WebCrawler
 		#Gems that are required
		require 'rubygems'
		require 'mechanize'
		require 'nokogiri'
		require 'open-uri'
		require 'json'

		#Other ruby files that are required
		#require_relative 'NameSkills'
		#require_relative 'AlsoViewed'
		require_relative 'webcrawler'
		require_relative 'AlsoViewed'

 		def search company, country
 			#This is to debug the app, it's displayed on the console

	 		#Initialize Mechanize
			agent = Mechanize.new
			#These rows may be unnecessary, remove if it proves problems for Windows/Linux
			agent.user_agent_alias = "Mac Safari"
			agent.follow_meta_refresh = true

			#Check if the company is already in the DB
			db_company = Company.find_by name: company.downcase
			p db_company
			if(db_company.present?)
				return true
			end

		end

		def crawl company, country

			p "VOY A CORRER EL WEBCRAWLER!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

			poi_tot, total_time1, total_time2 = webcrawlerfunc(company, country)
			puts "Adding your data to the MongoLab database. I can see the finish line now!"
			beginning_time = Time.now

			#Add data to the database.
			poi_tot.keys.each do |key|
				#Create the user if Doesn't exist
				user_name = poi_tot[key]["Name"]
				user_url = poi_tot[key]["LinkedIn URL"]

				db_user = User.find_by name: user_name.downcase
				if(!db_user.present?) #create the entity
					db_user = User.new(:name => user_name, :url => user_url)
					db_user.save
				end

				#Create the company if Doesn't exist
				db_company = Company.find_by name: company.downcase
				if(!db_company.present?) #create the entity
					db_company = Company.new(:name => company)
					db_company.save
				end

				#Create the skills if Doesn't exist, and add the skills to the user
				my_skills = db_user.skills
				poi_tot[key]["Skills"].each do |skill|
					db_skill = Skill.find_by name: skill.downcase
					if(!db_skill.present?) #create the entity
						db_skill = Skill.new(:name => skill)
						db_skill.save
					end

					unless my_skills.include? db_skill
				      db_user.skills << db_skill
				      db_user.save
				    end
				end

				#Add the company to the user
				db_user.company = db_company
			    db_user.save
			end


			end_time = Time.now
			total_time3 = end_time - beginning_time
			total_time = total_time1 + total_time2 + total_time3
			puts "Added to your database in #{total_time3} seconds."
			puts
			puts "Finished the job in #{total_time} seconds. Go have a look at your results!"

 		end
 	end
end