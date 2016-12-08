all:
	docker build -t xz-otp-18-elixir:1.3 -f xz-otp-18-elixir/1.3/Dockerfile .
	docker build -t xz-jenkins-slave-elixir:1.3 -f xz-jenkins-slave-elixir/1.3/Dockerfile .
	docker build -t xz-jenkins-slave-ruby:2.3 -f xz-jenkins-slave-ruby/2.3/Dockerfile .

tag:
	docker tag xz-otp-18-elixir:1.3 localhost:5000/xz-otp-18-elixir:1.3
	docker tag xz-jenkins-slave-elixir:1.3 localhost:5000/xz-jenkins-slave-elixir:1.3

push:
	docker push localhost:5000/xz-otp-18-elixir:1.3
	docker push localhost:5000/xz-jenkins-slave-elixir:1.3

.PHONY: all tag push
