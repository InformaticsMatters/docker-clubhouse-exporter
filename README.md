# A container image to Export Clubhouse data

![build](https://github.com/InformaticsMatters/docker-clubhouse-exporter/workflows/build/badge.svg)
![build latest](https://github.com/InformaticsMatters/docker-clubhouse-exporter/workflows/build%20latest/badge.svg)
![build tag](https://github.com/InformaticsMatters/docker-clubhouse-exporter/workflows/build%20tag/badge.svg)
![build stable](https://github.com/InformaticsMatters/docker-clubhouse-exporter/workflows/build%20stable/badge.svg)

![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/informaticsmatters/docker-clubhouse-exporter)

An image that uses the [Clubhouse] [exporter] (copied to this repo) to extract
data from Clubhouse to a volume mounted at `/export` and then (optionally)
write it to an AWS S3 bucket.

>   You don't need to mount a volume if you're backing-up the files to an
    AWS S3 bucket. A mounted volume is needed if you;re not using AWS S3 in
    order to persist the export once the backup container has completed.

The container is configured by a number of environment variables: -

*   `CLUBHOUSE_API_TOKEN` The Clubhouse API token
*   `BUCKET_NAME` The AWS S3 bucket name, if writing export to AWS s3
*   `AWS_ACCESS_KEY_ID` The AWS Access Key with permission to write to the bucket
*   `AWS_SECRET_ACCESS_KEY` teh AWS secret key

## Building
The container image is built using Travis. Inspect the project's `.travis.yml`
to see how the container image is built. The simplest thing to do is
to run the Docker build command: -

    $ docker build -t informaticsmatters/clubhouse-exporter:latest .

## Execution
You can run the container locally to quickly archive your Clubhouse data
to the current directory (where a `./data` directory will be created)...

    $ export CLUBHOUSE_API_TOKEN=00000000
    $ docker run \
        -v ${PWD}:/export \
        -e CLUBHOUSE_API_TOKEN=${CLUBHOUSE_API_TOKEN} \
        --rm informaticsmatters/clubhouse-exporter:latest

Or you can deploy it to Kubernetes as a CronJob for regular execution.
Where you can checkout our peer [Ansible] repository.

---

[ansible]: https://github.com/InformaticsMatters/clubhouse-exporter-ansible
[clubhouse]: https://clubhouse.io
[exporter]: https://github.com/clubhouse/exporter
