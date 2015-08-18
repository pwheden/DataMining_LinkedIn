# Lettuce
_Project using Ruby on Rails and MongoDB. About mining LinkedIn, providing students with superb knowledge about companies they are interested in._
August 18, 2015.

## Idea behind project
Do you, as a student, have a company that you are really interested in and would like to work for in the future?
Do you want to know what experience the employees that are in said company have, what school they went to, what skills they possess?
Lettuce makes use of publicly available information, and helps you based on a given company, to find the _skills_ that
are most common in that company. In addition to that, we find the person most similar to you so that you can have someone
to compare yourself with. What did he/she do during university? Should I participate more in the student community? Learn Python?

## Current Status
The project is fully functional running locally on any computer, however at the moment I am in a process of migrating
the project to Heroku, where it will run through a web server. The project can be visited on www.lettuce.se, but searching
for information by filling in the form won't get you anywhere. It is my sincere hope to have everything up and running by
the beginning of September, since this is a project I am working with on evenings/weekends.

## Partial Goals
* Create a functional webcrawler capable of gathering useful information based on user input/keywords
* Create an algorithm extracting popular skills in a company
* Design an algorithm implementing Jaccard Similarity, finding the person most similar to the user within a company
* Connect the project to an online database, removing the need to gather the same information again on different
computers
* Create a front-end
* Upload the project to Heroku, such that it is able to run from the browser
* Gather user-statistics with Google Analytics


## To do
* Using Heroku's web and working dynos, restructure the controllers of the project and distribute tasks to the web and working dynos
* Connect the project to a mail-service, sending out e-mails to users with results when they are calculated. This frees up space
on the site and lets the user do something else while they wait for us to crunch the numbers.

## Programs/Gems/Software used
* The project is built with _Ruby on Rails_
* _MongoDB_ is used as database, with _MongoLab_ as the online database
* The webcrawler is designed with the _Mechanize_ gem
* It is uploaded online through _Heroku_
* Frontend is done with _Bootstrap_
