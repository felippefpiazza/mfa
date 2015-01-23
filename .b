
[1mFrom:[0m /mnt/hgfs/SRC/mfa/app/models/auth_sms.rb @ line 61 AuthSms#send_smsglobal:

    [1;34m46[0m: [32mdef[0m [1;34msend_smsglobal[0m
    [1;34m47[0m:   uri = URI([1;34;4mSMS_PARAMS[0m[[33m:smsglobal_url[0m])
    [1;34m48[0m:   params = {
    [1;34m49[0m:                   [31m[1;31m'[0m[31maction[1;31m'[0m[31m[0m => [1;34;4mSMS_PARAMS[0m[[33m:smsglobal_action[0m],
    [1;34m50[0m:                   [31m[1;31m'[0m[31muser[1;31m'[0m[31m[0m => [1;34;4mSMS_PARAMS[0m[[33m:smsglobal_user[0m],
    [1;34m51[0m:                   [31m[1;31m'[0m[31mpassword[1;31m'[0m[31m[0m => [1;34;4mSMS_PARAMS[0m[[33m:smsglobal_pass[0m],
    [1;34m52[0m:                   [31m[1;31m'[0m[31mfrom[1;31m'[0m[31m[0m => [1;34;4mSMS_PARAMS[0m[[33m:smsglobal_from[0m],
    [1;34m53[0m:                   [31m[1;31m'[0m[31mto[1;31m'[0m[31m[0m => [1;36mself[0m.client.phone2sms,
    [1;34m54[0m:                   [31m[1;31m'[0m[31mtext[1;31m'[0m[31m[0m => [31m[1;31m'[0m[31mMFA Code: [1;31m'[0m[31m[0m + [1;36mself[0m.access_token
    [1;34m55[0m:                  }
    [1;34m56[0m:   uri.query = [1;34;4mURI[0m.encode_www_form(params)
    [1;34m57[0m: 
    [1;34m58[0m:   res = [1;34;4mNet[0m::[1;34;4mHTTP[0m.get_response(uri)                  
    [1;34m59[0m:   [1;36mself[0m.save
    [1;34m60[0m:   
 => [1;34m61[0m:   binding.pry
    [1;34m62[0m: [32mend[0m

