const url = "https://api.github.com/repos/oo1o1o12/BFDI-Branches-Archive/releases";
try {
    const response = await fetch(url);
    if (!response.ok) {
        const error = document.getElementById('versionsContainer');
        error.innerHTML = "<br>An error occurred!!<br>" + response.status;
        error.style = "color: #FF474C;"
        throw new Error(`${response.status}`);
    }
    const result = await response.json();
    for (var i = 0; i < result.length; i++) {
        //console.log(result[i].tag_name);
        //console.log(i);
        let downloadPCKButton = `Missing!`
        let platformDownloads = ""
        if (result[i].assets[0] != null) {
            downloadPCKButton = `<a href="${result[i].assets[0].browser_download_url}">PCK</a>`
            if (result[i].assets[1] != null) {
                for (var ii = 0; ii < result[i].assets.length; ii++) {
                    console.log(ii)
                    let platformDownload = `<div style="font-size: 14px; color: #94ff9b;"> Platform Specific:<br></div>`
                    if (result[i].assets[ii].name == "branches_windows.zip") {
                        platformDownload = `<a href="${result[i].assets[ii].browser_download_url}">
                        <img src="images/buttons/windows.png" style="max-width: 40px;">
                        </a>`
                    } else if (result[i].assets[ii].name == "branches_macos.zip") {
                        platformDownload = `<a href="${result[i].assets[ii].browser_download_url}">
                        <img src="images/buttons/macos.png" style="max-width: 40px;">
                        </a>`
                    } else if (result[i].assets[ii].name == "branches_linux.zip") {
                        platformDownload = `<a href="${result[i].assets[ii].browser_download_url}">
                        <img src="images/buttons/linux.png" style="max-width: 40px;">
                        </a>`
                    }

                    //if (platformDownloads === "") {
                    platformDownloads = platformDownloads + platformDownload
                    //} else {
                    //    platformDownloads = platformDownloads + " / " + platformDownload
                    //}
                }
                //console.log(platformDownloads)
            }
        }
        const cardHTML = `
  				<div style="text-align: center;">
  					<h3 style="color: ${result[i].prerelease ? "#FF7F7F" : "lightblue"}; margin: 0 0 5px 0; font-size: 30px;">
       			            ${result[i].tag_name}
									<div style="font-size: 16px; color: gray; padding: 0px;">
										${result[i].prerelease ? "(beta)" : "(release)"}
									</div>
       			        </h3>
  								<div>
										${downloadPCKButton}<br>${platformDownloads}
  								</div>
 				</div>
       			`;
        const version = document.createElement('div');
        version.innerHTML = cardHTML;
        document.getElementById('versionsGrid').appendChild(version);
    }
} catch (error) {
    console.error(error.message);
    console.info(error.lineNumber);
}