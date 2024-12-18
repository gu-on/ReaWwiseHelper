package.path = package.path .. ';'
    .. debug.getinfo(1).source:match("@?(.*[\\|/])") .. '/src/?.lua' .. ";"
    .. debug.getinfo(1).source:match("@?(.*[\\|/])") .. '/3rd/?.lua' .. ";"

Object = require('classic')
WaapiClient = require('waapiclient')
JsonArray = require('jsonarray')
JsonMap = require('jsonmap')