//const express  = require('express');
//const router   = express.Router();

const Koa = require('koa');
const Router = require('koa-router');

const app = new Koa();
const router = new Router();


const rp = require('request-promise')
const esClient = require('../client');
const searchDoc = async function(indexName, mappingType, payload){
    return await esClient.search({
        index: ['3ocmlf075ak2vfatq8k2vfatq7', 'test_gruop_a'],
        //index: [indexName],
//        type: mappingType,
        body: payload
    });
}

module.exports = searchDoc;


