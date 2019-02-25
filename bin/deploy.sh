#!/usr/bin/env bash

REDIS_URL=$(cd server && DISABLE_SPRING=1 bin/rails runner "puts Catch::Application.credentials.dig :production, :redis_url")
(cd client/web && ember deploy production)
git subtree push --prefix server heroku master
