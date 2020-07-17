const es = require('elasticsearch');
const esClient = new es.Client({
    host: '192.168.0.56:9200'
	,requestTimeout: 3000
    // ,log: 'trace'
});

//module.exports = esClient;
// const searchDoc = async function(indexName, mappingType, dataload){
const searchDoc = async function(indexName,  dataload){
    return await esClient.search({
				// index: ['5a8ufnn5k35w2dm6k35w2dm5', 'group_ivs'],
//				index: ['test_gruop_a'],
        index: indexName,
//        type: mappingType,
        body: dataload
    });
}

//module.exports = searchDoc;
exports.searchDoc = searchDoc;


function initIndex(indexName) {
    return esClient.indices.create({
        index: indexName
    });
}
exports.initIndex = initIndex;


function indexExists(indexName) {
    return esClient.indices.exists({
        index: indexName
    });
}
exports.indexExists = indexExists;


function deleteIndex(indexName, documentName) {
    return esClient.indices.delete({
        // index: indexName,
        // id: documentName
        index: indexName,
        body: {
            query: {
                match: {
                    "filename": documentName
                }
            }
        }
    });
}
exports.deleteIndex = deleteIndex;
