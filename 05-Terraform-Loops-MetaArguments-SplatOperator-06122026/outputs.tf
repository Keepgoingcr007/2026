output "instance_public_ip"{
    value = aws_instance.this.public_ip
    description = "The public IP address of the EC2 instance."

}

output "instance_public_dns"{
    value = aws_instance.this.public_dns
    description = "The public DNS name of the EC2 instance."}


output "for_output_list" {
    description ="For Loop with List"
    value = [for instance in aws_instance.myec2vm: instance.public_dns]
    
}    

output "for_output_map1" {
    description ="For Loop with Map basic version"
    value = {for instance in aws_instance.myec2vm: instance.id => instance.public_dns}
    
}   

output "for_output_map2" {
    description ="For Loop with Map advanced version"
    value = {for c,instance in aws_instance.myec2vm: c => instance.public_dns}
    
}   

output "for_output_map2-splat" {
    description ="Map usig SPLAT operator"
    value = aws_instance.myec2vm[*]public_dns
    
} 