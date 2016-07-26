all:
	docker build -t xz-otp-18-elixir:1.3 -f xz-otp-18-elixir/1.3/Dockerfile .
	docker build -t xz-jenkins-slave-elixir:1.3 -f xz-jenkins-slave-elixir/1.3/Dockerfile .

.PHONY: all
