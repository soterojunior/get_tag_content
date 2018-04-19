-- Create the user account and grant it all privileges on the databases.
grant all PRIVILEGES on tag_content_api_development.* to tag_content_api@localhost identified by 'T@gC0nT&Nt';
grant all PRIVILEGES on tag_content_api_test.* to tag_content_api@localhost identified by 'T@gC0nT&Nt';
grant all PRIVILEGES on tag_content_api.* to tag_content_api@localhost identified by 'T@gC0nT&Nt';
