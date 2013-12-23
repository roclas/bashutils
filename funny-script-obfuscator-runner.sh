#!/usr/bin/env bash

sh $1 | base64 -d |sh
