heroku pipelines:destroy sfdxtdtm-pipeline
heroku apps:destroy -a sfdxtdtm-dev -c sfdxtdtm-dev
heroku apps:destroy -a sfdxtdtm-staging -c sfdxtdtm-staging
heroku apps:destroy -a sfdxtdtm-prod -c sfdxtdtm-prod
rm -- "destroysfdxtdtm.sh"
