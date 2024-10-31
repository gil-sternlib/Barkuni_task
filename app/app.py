from flask import Flask, jsonify
import os
from kubernetes import client, config

app = Flask(__name__)

@app.route('/')
def welcome():
    return """
    <h1>Welcome to Barkuni Corp!</h1>
    <p>This is a demonstration of our Kubernetes-based application.</p>
    <p><a href="/pods">View Kubernetes Pods</a></p>
    """

@app.route('/pods')
def list_pods():
    try:
        # Load kubernetes configuration
        if os.path.exists('/var/run/secrets/kubernetes.io/serviceaccount'):
            config.load_incluster_config()
        else:
            config.load_kube_config()

        v1 = client.CoreV1Api()
        pods = v1.list_namespaced_pod(namespace="kube-system")

        pod_list = []
        for pod in pods.items:
            pod_info = {
                "name": pod.metadata.name,
                "status": pod.status.phase,
                "ip": pod.status.pod_ip
            }
            pod_list.append(pod_info)

        return jsonify({"pods": pod_list})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)