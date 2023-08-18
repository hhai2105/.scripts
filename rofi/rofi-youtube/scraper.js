#!/usr/bin/env node
const { existsSync } = require("fs");
const { mkdir, writeFile, readdir, unlink } = require("fs/promises");
const { join } = require("path");
const yt = require('youtube-search-without-api-key');


let imageDir = "./images";
let search = "";
for(let i = 2; i < process.argv.length - 1; ++i){
	search += process.argv[i] + " ";
}
search += process.argv[process.argv.length - 1]

async function deleteAllFilesInDir(dirPath) {
	try {
		const files = await readdir(dirPath);
		const deleteFilePromises = files.map(file =>
			unlink(join(dirPath, file)),
		);

		await Promise.all(deleteFilePromises);
	} catch (err) {
		console.log(err);
	}
}

async function fetchimage(url, id){
	// fetch image with url and save to imageFolder/id
    if (!existsSync(imageDir)) await mkdir(imageDir);
	const imagePath = join(imageDir, `${id}.jpeg`); // Change the extension based on the actual image format
	const res = await fetch(url);
    const blob = await res.blob();
	const bos = blob.stream();
	await writeFile(imagePath, bos);
	return imagePath
}

async function a(search){
	const data = await yt.search(search);
	for(let i = 0; i < data.length; i++){
		imagePath = await fetchimage(data[i].snippet.thumbnails.url, data[i].id.videoId);
		val = data[i].id.videoId + " " + data[i].snippet.title;
		console.log( val + "\x00icon\x1f" + imagePath);
	}
}

deleteAllFilesInDir(imageDir)
a(search)
