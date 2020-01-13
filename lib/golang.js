'use strict'

const ref = require('ref')
const ffi = require('ffi')

module.exports.rpc_handler = (port, event, context, callback) => {

	let events_APIGatewayProxyResponse	= ref.types.void;
  	let events_APIGatewayProxyResponsePtr	= ref.refType(events_APIGatewayProxyResponse);

  const client = ffi.Library(
			__dirname + '/libclient',
			{
			'invoke': [events_APIGatewayProxyResponsePtr, ['int', 'string','string']]
			});

  const res = JSON.parse(ref.readCString(client.invoke(
				port,
				JSON.stringify(context),
				JSON.stringify(event)
			)));
  console.log(res)
  callback(null, res);

  // Use this code if you don't use the http event with the LAMBDA-PROXY integration
  // callback(null, { message: 'Go Serverless v1.0! Your function executed successfully!', event });
};
