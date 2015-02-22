# scicompass - python

This repo has **halted** because no way to do **async** MySQL query on SAE.

Note:
---
I choose Tornado for this project because its generator-based async pattern.

SAE did support tornado worker and `IOLoop`, but only Tornado v3.1. What's worse it rely on monky patch to work on SAE, which looks like a black box. So I can't use `IOStream` to connect to MySQL Server, so stop thinking about *Tornado-MySQL*. It's also a day dream to upload and use a newer version of tornado.

SAE also support threading, but it is fake threading. Which means if you block in child thread, the main thread is also blocked. Actually you only run one thread. So stop thinking about *ThreadPoolExecutor*.

BAE, even the BAE 3.0, still only support WSGI, goodbye.

In conclusion, I can't find a PaaS platform in China to allow me to do async MySQL query in Tornado. If so, there is no meaning to write in Python/Tornado, and I switch to PHP/CodeIgniter. Looking forward to hearing updates from SAE and switch back.
