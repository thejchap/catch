#!/usr/bin/env bash

(cd client/web && ember deploy production)
git subtree push --prefix server heroku master
