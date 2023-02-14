from omni.services.core import main
import omni.client

def hello_world():
    omni.client.set_log_callback(
        lambda threadName, component, level, message: print("[{}] [{}] [{}] {}".format(threadName, component, level, message))
    )

    omni.client.set_log_level(omni.client.LogLevel.DEBUG) 

    if not omni.client.initialize():
        return "Failed to initialize Omni Client"

    print("$$$$ Omni Client initialized" + omni.client.get_version()) # version 2.17
        
    g_1 = omni.client.register_authorize_callback(authentication_callback)
    g_2 = omni.client.register_connection_status_callback(connectionStatusCallback)

    valid, list = omni.client.list("omniverse://host.docker.internal:3180/")

    for i in list:
        print("$$$$ {}".format(i))

    omni.client.live_wait_for_pending_updates()
    
    g_1 = None
    g_2 = None

    return "Hello World {} {}".format(valid, list)

def authentication_callback(url):
    print("$$$$ Authenticating to {}".format(url)) # is printed once
    return "$omni-api-token", "<token>"

def connectionStatusCallback(url, connectionStatus):
    print("$$$$ Connection status to {} is {}".format(url, connectionStatus))

main.register_endpoint(
    "get", 
    "/hello-world", 
    hello_world
)
