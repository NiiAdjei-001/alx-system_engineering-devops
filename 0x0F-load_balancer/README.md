# 0x0F. Load balancer

Load balancer. What is it? What does it do? How significant is it?

## What is a Load Balancer?

Simply put it is a server program running a program that redistributes traffic to other servers.

## How significant is it?

It is important for scaling. All servers have performance and resource limits. They cannot handle massive influx of traffic without glitching or generating problems which would impact customer experience when using your servers. The loadbalancer is the means of fixing this scaling problem.

## Advantages of Load Balancer

1. Reduce workload on an individual server
2. Large volumes of work can be done due to concurrency
3. Increased performance of application because of faster response
4. No single point of failure in a load balancing environment. If a server crash it does not impact the application's execution as trafic is redirected from the crashed server to the active servers.
5. The right load balancing algorithm increases the efficeincy of the applications running. The right algorithm ensures optimal usage of all server resources thus preventing strain on particular servers which could affect the overall performance of the application
6. Scalability: We can increase or decrease the number of servers based on specific strategic needs without shutting down the application
7. Enterprise Application have higher reliability with a load balancer environment
8. Increased Security: Physical servers and IPS are abstracted in certain cases

## 2 Types of Load Balancers

- Software Load Balancer
- Hardware Load Balancer

### Software Load Balancer

They are programs that implement combinations of load balancing scheduling algorithms. 

#### 1 Weighted Scheduling Algorithm

Work is assigned to server according to the weight assigned to the server. This is more technical as it would require the adminsitrator to have knowledge about the specs and capabilities of the servers.

#### Round Robin Scheduling

Request are shared sequentially amongst all the servers of the application.

#### Least Connection First Scheduling

Requests are served to the server with the least number of response.

#### Example of Software Load Balancer

1. HAProxy - A TCP load balancer
2. NGINX - An http load balancer with ssl termination support
3. mod_athena - Apache based http load balancer
4. Varnish
5. Balance
6. LVS (Linux virtual server)

### Hardware Load Balancer

Hardware load balancers are refered to as specialized routers or switches deployed inbetwen the client and the server.

Implementation is at the OSI model Layer 4 (Transport Layer) and the Layer 7(The Application Layer)

## Background Context
You have been given 2 additional servers:
- gc-[STUDENT_ID]-web-02-XXXXXXXXXX
- gc-[STUDENT_ID]-lb-01-XXXXXXXXXX

Let’s improve our web stack so that there is redundancy for our web servers. This will allow us to be able to accept more traffic by doubling the number of web servers, and to make our infrastructure more reliable. If one web server fails, we will still have a second one to handle requests.

For this project, you will need to write Bash scripts to automate your work. All scripts must be designed to configure a brand new Ubuntu server to match the task requirements.

## Tasks

### 0. Double the number of webservers
In this first task you need to configure `web-02` to be identical to `web-01`. Fortunately, you built a Bash script during your `web server project`, and they’ll now come in handy to easily configure `web-02`. Remember, always try to automate your work!

Since we’re placing our web servers behind a load balancer for this project, we want to add a custom Nginx response header. The goal here is to be able to track which web server is answering our HTTP requests, to understand and track the way a load balancer works. More in the coming tasks.

Requirements:

- Configure Nginx so that its HTTP response contains a custom header (on `web-01` and `web-02`)
    - The name of the custom HTTP header must be `X-Served-By`
    - The value of the custom HTTP header must be the hostname of the server Nginx is running on
    Write `0-custom_http_response_header` so that it configures a brand new Ubuntu machine to the requirements asked in this task
        Ignore SC2154 for `shellcheck`

Example:
```bash
sylvain@ubuntu$ curl -sI 34.198.248.145 | grep X-Served-By
X-Served-By: 03-web-01
sylvain@ubuntu$ curl -sI 54.89.38.100 | grep X-Served-By
X-Served-By: 03-web-02
sylvain@ubuntu$
```
If your server’s hostnames are not properly configured (`[STUDENT_ID]-web-01` and `[STUDENT_ID]-web-02`.), follow this [tutorial](https://repost.aws/knowledge-center/linux-static-hostname).

###  1. Install your load balancer
Install and configure HAproxy on your `lb-01` server.

Requirements:

- Configure HAproxy so that it send traffic to `web-01` and `web-02`
- Distribute requests using a roundrobin algorithm
- Make sure that HAproxy can be managed via an init script
- Make sure that your servers are configured with the right hostnames: `[STUDENT_ID]-web-01` and `[STUDENT_ID]-web-02`. If not, follow this [tutorial](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/set-hostname.html).
- For your answer file, write a Bash script that configures a new Ubuntu machine to respect above requirements

Example:
```bash
sylvain@ubuntu$ curl -Is 54.210.47.110
HTTP/1.1 200 OK
Server: nginx/1.4.6 (Ubuntu)
Date: Mon, 27 Feb 2017 06:12:17 GMT
Content-Type: text/html
Content-Length: 30
Last-Modified: Tue, 21 Feb 2017 07:21:32 GMT
Connection: keep-alive
ETag: "58abea7c-1e"
X-Served-By: 03-web-01
Accept-Ranges: bytes

sylvain@ubuntu$ curl -Is 54.210.47.110
HTTP/1.1 200 OK
Server: nginx/1.4.6 (Ubuntu)
Date: Mon, 27 Feb 2017 06:12:19 GMT
Content-Type: text/html
Content-Length: 612
Last-Modified: Tue, 04 Mar 2014 11:46:45 GMT
Connection: keep-alive
ETag: "5315bd25-264"
X-Served-By: 03-web-02
Accept-Ranges: bytes

sylvain@ubuntu$
```
### 2. Add a custom HTTP header with Puppet
Just as in task #0, we’d like you to automate the task of creating a custom HTTP header response, but with Puppet.

- The name of the custom HTTP header must be `X-Served-By`
- The value of the custom HTTP header must be the hostname of the server Nginx is running on
- Write `2-puppet_custom_http_response_header.pp` so that it configures a brand new Ubuntu machine to the requirements asked in this task

## Resources

https://intranet.alxswe.com/concepts/46
https://www.thegeekstuff.com/2016/01/load-balancer-intro/
