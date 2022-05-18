#!/usr/bin/env node
const validator = require('validator');
console.log(validator.isURL(process.argv[2]));
