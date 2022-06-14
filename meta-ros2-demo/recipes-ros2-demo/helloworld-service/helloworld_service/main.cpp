#include <cinttypes>
#include <memory>
#include <unistd.h>
#include "rclcpp/rclcpp.hpp"
#include "helloworld_msgs/srv/get_hello_message.hpp"

rclcpp::Node::SharedPtr g_node = nullptr;

void handle_hello(const std::shared_ptr<rmw_request_id_t> request_header,
                  const std::shared_ptr<helloworld_msgs::srv::GetHelloMessage::Request> request,
                  const std::shared_ptr<helloworld_msgs::srv::GetHelloMessage::Response> response)
{
    (void)request_header;

    std::string prefix("Hello ");
    response->message = prefix + request->name;
}

int main(int argc, char ** argv)
{
    rclcpp::init(argc, argv);
    g_node = rclcpp::Node::make_shared("helloworld_service");
    auto say_hello_server = g_node->create_service<helloworld_msgs::srv::GetHelloMessage>("hello",
                                                                                          handle_hello);
    rclcpp::spin(g_node);
    rclcpp::shutdown();
    g_node = nullptr;
    return 0;
}
