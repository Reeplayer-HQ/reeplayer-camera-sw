## [0.9.10] = 2022-09-20
### Added 
- Support "dev" and "prod" mode, using different backend service. 

## [0.9.9] = 2022-09-16
### Fixed
- Battery threshold issue 
- Display the storage as "MB" 
- Dynamic loading token for each API calling 
### Added 
- Temprature of the hardware 
- Set and display camera name 
- Set and display footage name 

## [0.9.8] = 2022-09-02
### Changed
- Use only the IP as the web gui url
- Add username and password for web gui 
### Fixed 
- Storage display bug 

## [0.9.7] = 2022-08-30
### 
- Duplicate 0.9.6 for testing 

## [0.9.6] = 2022-08-30
### Fixed
- Software update error 
- Uploading error
### Changed 
- Use port 8080 in web gui URL  

## [0.9.5] = 2022-08-28
### 
- No change from 0.9.4, used to test auto version update

## [0.9.4] = 2022-08-28
### Fixed 
- Auto update or manually update of the software in web page 
- Using default port number 80 for web page (so could be ignored in URL)
### Added 
- Battery percent in web page and in mobile app 
- All battery info send in the system status 

## [0.9.3] = 2022-08-22
### 
- No change from 0.9.2, used to test auto version update

## [0.9.2] = 2022-08-22
### Added 
- Auto update of software, by settings, or by user's operation
- Configure video streaming on demand for live preview (in web page only)  
- Remove port number in web gui URL (using default port 80)

## [0.9.1] = 2022-08-22
### Fixed 
- The live preview with video streaming in web page 

## [0.9.0] = 2022-08-22
### Added 
- Re-work docker containers for runtime deployment 

## [0.8.12] = 2022-07-17
### Added 
- Stop recording when the free disk space is less than a threshold (configurable)
- Increase the threads number for API thread pool (configurable)
- Split the video file by settings of the max file size (kb) or max file time (ns) 

### Fixed 
- Continuously display the time and size of the file when the recording is paused 
- Set the exposure compensation level to default value (0)
- Install the default testing serial and token files 


## [0.8.11] = 2022-07-02
### Changed
- Simplify the part id of the footage in uploading, with data time and sequential number only
- Capture errors during uploading and forward to the client in status 
- Make default recording video file name consists of data time and sequential number 

## [0.8.10] = 2022-06-25
### Fixed 
- Set and get the meta data for footage 
- Use the create time of the footage folder as the timestamp of the footage 

## [0.8.9] = 2022-06-24
### Fixed 
- Uploading file to S3 in non-multi-part mode 

## [0.8.8] = 2022-06-23
### Changed
- Recording workflow adjustment to the same as mobile app
- Uploading control on webpage  
### Fixed 
- Evaluate http status code both 200 and 201
- Bug fix for launch uploader node with docker-compose 

## [0.8.7] = 2022-06-23
### Fixed
- Fix config save bug 

## [0.8.6] = 2022-06-19
### Fixed
- Testing and fix bugs for uploading api 
- Bug fix for token and serial config 
### Changed
- Uploading status code 
- Support image scale for online calib response 

## [0.8.5] = 2022-06-10
### Fixed
- Online calib support by API 
- Raw images support by API 

## [0.8.4] = 2022-05-31
### Fixed
- Footage erase from api bug 
- Recording start from api bug

## [0.8.4] = 2022-05-31
### Fixed
- Sensor parameters and recording settings

## [0.8.3] = 2022-05-29
### Changed
- Custom health checking service in gRPC api 

## [0.8.2] = 2022-05-28
### Fixed
- Bugs for camera API 

## [0.8.1] = 2022-05-28
### Changed
- A new implementaiton of the Web GUI, for mobile device.

## [0.8.0] = 2022-05-20
### Changed
- Code refactoring 
- Re-work the Web GUI 
### Added 
- Recording ROI 
- Online calibration 
### Fixed
- Some bugs that caused failure in re-start live video 

## [0.7.5] = 2022-05-14
### Added
- Camera API for mobile app  
- Uploading management 

## [0.7.3] = 2022-05-10
### Added
- Settings ROI for recording 
### Fixed 
- Crash after recording mode switching 

## [0.7.2] = 2022-05-08
### Added
- Settings UI for recording 

## [0.7.1] = 2022-05-06
### Changed 
- Some naming convetions with hyphen to replace the underscore 
- Better recording settings 

## [0.7.0] = 2022-05-05
### Changed
- Reset the code struture, managing with the vcstool 
- A series of changes to improve the video quality 

## [0.6.8] = 2022-05-03
### Changed
- A test version for image quality

## [0.6.7] = 2022-03-28
### Changed
- Build on L4T 32.4.3 
- Fix compatible issues for L4T 

## [0.6.6] = 2022-03-27
### Changed
- re-write the nvarguscamerasrc plugin to open two sensors
- Using deepstream sdk as the framework of the pipeline 
- Support single session and multi-session mode for cameras to improve the sync  

## [0.6.5] = 2022-02-18
### Changed 
- Use sensor timestamp for sync;
- Use 3840x2160 as input resolution 
- Disable both stitched video and raw video mode 

## [0.6.4] = 2022-02-05
### Fixed 
- More strict timestamp sync, may lower the framerate; 

## [0.6.3] = 2022-02-02
### Fixed 
- Fix the bugs for the sync between cameras; 

## [0.6.2] = 2022-02-01
### Changed 
- Everything same as 0.6.1.0 but switched the camera's sensor IDs in config files. 

## [0.6.1] = 2022-01-31
### Added 
- Support recording modes for stitched + raw, raw, and calib videos; 
- Support live preview for raw videos; 

## [0.6.0] = 2022-01-28
### Changed 
- Complete implementation of calibration and video recording functions
- Complete implementation of camera software API 
- Adjustments on the GStreamer plugin design and the algorithm libraries 
- Record both stitched video and raw videos, support multiple streaming

## [0.5.3] = 2021-10-21
### Changed 
- Switch to L4T 32.6.1 
- Camera API 

## [0.5.2] = 2021-09-29
### Added 
- WiFi network settings to support WiFi/AP dual mode 

## [0.5.1] = 2021-09-11
### Fixed 
- Fix auto update issue for new installation  
- Fix video pipeline failure issue for new installation 

## [0.5.0] = 2021-09-10
### Changed 
- ROS based system 
- Docker based deployment 

## [0.3.2] = 2021-05-11
### Changed 
- manually calibration 
- updated seam finding 

## [0.3.1] = 2021-04-20
### Changed 
- Default config for resolution 4032x3040
- Support dump image for calibration 
- Support warping type switch between cylindrical and spherical

## [0.3.0] = 2021-03-24
### Changed 
- Enhanced deepstream pipeline to support both offline and online stitching, and real-time calibration; 
- Faster stitching pipeline with parallel processing; 
- Faster implementation of exposure compenstation and seam finding; 

### Added 
- Support recording of multi-stream video in single file and stitching for the video file;
- New GSteamer plugin to support real-time calibration for camera intrinsic calibration and transform estimation; 
- Daemon service "camerad" to support JSON-RPC for client software; 
- Reference client software "Reeplayer" for testing and demonstration; 
- Bash script to install and uninstall the software to start with system; 
- Bash script to build the software from source code and create installation package; 
- Bash script to auto download and update software version; 

## [0.2.2] - 2020-09-10
### Fixed
- Many bugs;  

## [0.2.1] - 2020-09-08
### Changed
- Modify the implementation to support all processings in GPU memeory; 

## [0.2.0] - 2020-08-16
### Added 
- Separate calibration and stitching algorithms; support offline calibration and online stitching; 
- Online stitching in deepstream pipeline; 

## [0.1.4] - 2020-08-02
### Added 
- White balance for stitching pipeline; 
- Quality (bitrate) control for output video; 

## [0.1.3] - 2020-07-23
### Fixed
- Fix the bug in closing the last video file (unplayable video) when recording to split video files; 

### Added 
- Support recording to single video file (refer to [sink3] in config file); 

## [0.1.2] - 2020-07-19
### Added
- Shell scripts that start and stop the video recording in background; 
- Shell scripts to install systemd service that launches the video recording on system startup; 

## [0.1.1] - 2020-07-18
### Fixed 
- Ignore incomplete frames pair from two cameras; 

### Added 
- Config file for offline sititching application;  

### Changed 
- Wrap low level algoirhtm implementation to a library "videostitching";
- Organize desktop application to "videostitching-app" project;  
- All config files in "config" folder; 
- All shell scripts in "scripts" folder; 

## [0.1.0] - 2020-07-07
- Software installation documents for Jetson hardware and Ubuntu system (cloud server); 
- A GStreamer plugin (software framework) based on DeepStream SDK to work with two cameras; 
- DeepStream pipeline to record side-by-side video file from two cameras; 
- A optimized video stitching pipeline based on the image stitcher of OpenCV; 
- A desktop application for Ubuntu system to complete offline video stitching; 
