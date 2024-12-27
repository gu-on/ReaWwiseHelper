---@class iterator

package.path = package.path .. ';' .. debug.getinfo(1).source:match("@?(.*[\\|/])") .. '?.lua'

Object = require('classic')
Utilities = require('utilities')
WaapiClient = require('waapiclient')
JsonArray = require('jsonarray')
JsonMap = require('jsonmap')