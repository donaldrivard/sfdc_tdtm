heroku pipelines:destroy sfdx_tdtm-pipeline
heroku apps:destroy -a sfdx_tdtm-dev -c sfdx_tdtm-dev
heroku apps:destroy -a sfdx_tdtm-staging -c sfdx_tdtm-staging
heroku apps:destroy -a sfdx_tdtm-prod -c sfdx_tdtm-prod
rm -- "destroysfdx_tdtm.sh"
