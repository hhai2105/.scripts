#!/usr/bin/env node
const yt = require('youtube-search-without-api-key');


let search = "";
for(let i = 2; i < process.argv.length - 1; ++i){
	search += process.argv[i] + " ";
}
search += process.argv[process.argv.length - 1]

async function a(search){
	const data = await yt.search(search);
	for(let i = 0; i < data.length; i++){
		console.log(data[i].id.videoId + " " + data[i].snippet.title);
	}
}
a(search)
