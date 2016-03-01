1. Unzip & place the files in your web server root directory
2. Load the db "mydomain_db.sql" in your database.
3. Update file: cgi-bin/dream.pm, admin/dbconfig.php & social/dbconfig.php => Update DB Name, DB User and DB Password.

4. Update launchleader.ini [Important: Ideally place this file in a safe location not browsable by anonymous. You can also make inaccisable to view in browser]
    Update DB.param table
    update param set param_value='sk_live_MY_STRIPE_PRIVATE_KEY' where param_name='STRIPE_PRIVATE_KEY';
    update param set param_value='pk_live_MY_STRIPE_PUBLIC_KEY' where param_name='STRIPE_PUBLIC_KEY';
    update param set param_value='ca_MY_STRIPE_CLIENT_ID' where param_name='STRIPE_CLIENT_ID';
    update param set param_value='MY_FB_APP_ID' where param_name='FB_APP_ID';
    update param set param_value='admin@mydomain.com' where param_name='SIVI_ADMIN_EMAIL';
    update param set param_value='info@mydomain.com' where param_name='FROM_EMAIL_ADDRESS';

5. Update emails in admin/dostripe.php [Todo: we should take it from param table]

6. Change uploader dir path in: uploader/upload.php and give appropriate permissions.

7. Access to your domain: yourdomain.com
    7.1. Test user/pass: testuser / pass
    7.2. Admin account user/pass: admin@mydomain.com / pass
         Direct Link: https://www.yourdomain.com/admin/dashboard?u=admin@mydomain.com&p=pass

