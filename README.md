<snippet>
  <content>
# EMCDash

EMCDash is a custom dashboard based on the Dashing framework. It is primarily intended for EMC internal and partner use. EMCDash uses OPSconsole
APIs to retrieve install base and service request data. Widgets have been modified to support the ability to drill down through RESTful 
microservices (an an example, a service that generates CSVs on demand is the current click action). As more services become available and data
becomes available through RESTful calls, the ability to programmatically complete end-to-end processes that currently take weeks in a single click
could become possible. Outside of general learning, the intention of this project is to show a small glimpse of what is possible given the APIs
that are available today.  

## Installation

#### Ubuntu 14.04 Installation
Install Dashing following the instructions [here](http://www.dashing.io). If you don't have Ruby installed, I would reccomend using [RVM](https://rvm.io/rvm/install).
Once Dashing is installed, clone this repo or download the contents to your machine. Then, modify /config/example.json to include the OPSconsole URIs
as well as your credentials, and rename to config.json. Please contact me if you do not know what those URIs are. I have purposely ommited these to
avoid any internal issues. 

## Usage
Once configured run this from inside of the emcdash folder:
	dashing start
Or to run in daemon mode:
	dashing start -d
Then navigate to this url in your browser for the rotating sample:
	http://localhost:3030/msdashtv
Or here for the static sample:
	http://localhost:3030/emctv

## Modifying GDUNs

##Licensing
Licensed under the Apache License, Version 2.0 (the .License.); you may not use this file except in compliance with the License. You may 
obtain a copy of the License at <http://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an .AS IS. 
BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions
and limitations under the License.
