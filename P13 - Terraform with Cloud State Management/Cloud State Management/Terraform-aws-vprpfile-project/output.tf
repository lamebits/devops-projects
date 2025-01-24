output "RDSEndPoint"{
    description = "RDS EndPoint"
    value = aws_db_instance.vprofile-rds.endpoint
}

output "MemCacheEndPoint"{
    description = "MemCache EndPoint"
    value = aws_elasticache_cluster.vprofile-cache.configuration_endpoint
}

output "RabbitMQEndPoint"{
    description = "RabbitMQ EndPoint"
    value = aws_mq_broker.vprofile-rmq.instances.0.endpoints
}