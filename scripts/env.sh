
site_a=ec2-35-160-196-154.us-west-2.compute.amazonaws.com
site_b=ec2-35-161-90-244.us-west-2.compute.amazonaws.com

declare -a data_hosts=( $site_a $site_b )

declare -a locator_hosts=( $site_a $site_b )

all_hosts=( $(echo "${data_hosts[@]} ${locator_hosts[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' ') )

remote_dir=/home/centos/gemfire

SSH_USER=centos
user=${SSH_USER}
