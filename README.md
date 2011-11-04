Update Alerter
==============

This is just a test application to demonstrate how one could create an alert 
system for notifying the users of new features.

Uses:
* Rails 3.1
* Rspec
* Authentication using Rails 3.1 has_secure_password feature
* jQuery
* Zurb Foundation for CSS
* SimpleForm for form helpers

Rake Tasks
----------

You'll need an admin user to create "update messages". You can create new users
by using the registration page or using a rake task. You can make existing 
users into admins using a rake task:

    rake users:admin   # Make existing user admin
    rake users:create  # Create a new user



