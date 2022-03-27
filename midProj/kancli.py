#!/usr/bin/env python3
import click
from boto3 import client

def get_state_reason(instance):
    instance_state = instance['State']['Name']
    if instance_state != 'running':
        return instance['StateReason']['Message']

def get_public_ip_reason(instance):
    if "PublicIpAddress" in instance:
        return instance['PublicIpAddress']

def get_instance_status(instance_id):
    resp = ""
    my_instances = client('ec2')
    try:
        resp = my_instances.describe_instance_status(InstanceIds=[str(instance_id)], IncludeAllInstances=True)
        status_code = resp['InstanceStatuses'][0]['InstanceState']['Code']
    except Exception as e:
        status_code = 0
    finally:
        return status_code

@click.group()
@click.option('--debug/--no-debug', default=False)
@click.pass_context
def kancli(ctx, debug):
    click.echo('Welcome to kancli')
    ctx.obj['DEBUG'] = debug


@kancli.command()
@click.pass_context
def get_instances(ctx):
    ctx
    click.echo('Im going to get instances, debug mode is %s' % 'on' if ctx.obj['DEBUG'] else ' debug is off')
    my_instances = client('ec2').describe_instances()
    click.echo(my_instances)
    instances_data = []
    instance_data_dict_list = []

    for instance in my_instances['Reservations']:
        for data in instance['Instances']:
            if (data['State']['Name'] != 'terminated' and data['State']['Name'] != 'shutting-down'):
                instances_data.append(data)

    for instance in instances_data:
        try:
            if instance['State']['Name'] != "terminated" and instance['State']['Name'] != "shutting-down":                
                instance_data_dict = {}
                instance_data_dict['Cloud'] = 'aws'
                instance_data_dict['Region'] = client('ec2').meta.region_name
                instance_data_dict['Id'] = instance['InstanceId']
                instance_data_dict['Type'] = instance['InstanceType']
                instance_data_dict['ImageId'] = instance['ImageId']
                instance_data_dict['LaunchTime'] = instance['LaunchTime']
                instance_data_dict['State'] = instance['State']['Name']
                instance_data_dict['StateReason'] = get_state_reason(instance)
                instance_data_dict['SubnetId'] = instance['SubnetId']
                instance_data_dict['VpcId'] = instance['VpcId']
                instance_data_dict['MacAddress'] = instance['NetworkInterfaces'][0]['MacAddress']
                instance_data_dict['NetworkInterfaceId'] = instance['NetworkInterfaces'][0]['NetworkInterfaceId']
                instance_data_dict['PrivateDnsName'] = instance['PrivateDnsName']
                instance_data_dict['PrivateIpAddress'] = instance['PrivateIpAddress']
                instance_data_dict['PublicDnsName'] = instance['PublicDnsName']
                instance_data_dict['PublicIpAddress'] = get_public_ip_reason(
                    instance)
                instance_data_dict['RootDeviceName'] = instance['RootDeviceName']
                instance_data_dict['RootDeviceType'] = instance['RootDeviceType']
                instance_data_dict['SecurityGroups'] = instance['SecurityGroups']
                instance_data_dict['Tags'] = instance['Tags']

                instance_data_dict_list.append(instance_data_dict)
                click.echo(instance_data_dict_list)
        except Exception:
            raise


@kancli.command()
@click.pass_context
@click.option('-i', '--instance-id', required = True, type = str, help = "stop instance")
def stop_instances(ctx, instance_id):
    """HELP for stop-instances"""
    my_instances = client('ec2')
    status_code = get_instance_status(instance_id)
    if status_code == 16:
            
        click.echo('im going to stop instances {}'.format(instance_id))

        stop = click.confirm('Are you sure????')
        if stop:
            click.echo("hasta la vista {}".format(instance_id))
            my_instances.stop_instances(InstanceIds=[instance_id])
        else:
            click.echo("instance not stopped, lucky")
    else:
        click.echo("instance {} does not exist".format(instance_id))


@kancli.command()
@click.pass_context
@click.option('-i', '--instance-id', required = True, type = str, help = "start instance")
def start_instances(ctx, instance_id):
    """HELP for start-instances"""
    my_instances = client('ec2')
    status_code = get_instance_status(instance_id)
    if status_code != 16:
            
        click.echo('im going to start instances {}'.format(instance_id))

        stop = click.confirm('Are you sure????')
        if stop:
            click.echo("starting instance {}".format(instance_id))
            my_instances.start_instances(InstanceIds=[instance_id])
        else:
            click.echo("aborted, instance not started")
    else:
        click.echo("instance {} does not exist".format(instance_id))

@kancli.command()
@click.pass_context
@click.option('-i', '--instance-id', required = True, type = str, help = "terminate instance")
def terminate_instances(ctx, instance_id):
    """HELP for terminate-instances"""
    my_instances = client('ec2')
    status_code = get_instance_status(instance_id)
    if status_code != 0:  
        click.echo('im going to terminate instances {}'.format(instance_id))
        stop = click.confirm('Are you sure????')
        if stop:
            click.echo("terminate instance {}".format(instance_id))
            my_instances.terminate_instances(InstanceIds=instance_id)
        else:
            click.echo("aborted, instance not terminated")
    else:
        click.echo("instance {} does not exist".format(instance_id))


if __name__ == '__main__':
    kancli(obj = {})