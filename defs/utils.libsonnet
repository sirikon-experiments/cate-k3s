local keyValues(obj) = std.map(function(x) { key: x, value: obj[x] }, std.objectFields(obj));

local AppLabels(name) = {
    app: name
};

local Deployment(name, config) = {
    apiVersion: 'apps/v1',
    kind: 'Deployment',
    metadata: {
        name: name + '-deployment',
        labels: AppLabels(name)
    },
    spec: {
        replicas: 1,
        selector: { matchLabels: AppLabels(name) },
        template: {
            metadata: { labels: AppLabels(name) },
            spec: {
                containers: [{
                    name: name,
                    image: config.image,
                    ports: [{
                        containerPort: config.port
                    }],
                }]
            },
        },
    },
};

local Service(name, config) = {
    apiVersion: 'v1',
    kind: 'Service',
    metadata: {
        name: name + '-service',
    },
    spec: {
        selector: AppLabels(name),
        ports: [{
            port: config.port,
            targetPort: config.port
        }],
    },
};

local Ingress(name, config) = {
    apiVersion: 'networking.k8s.io/v1',
    kind: 'Ingress',
    metadata: {
        name: name + '-ingress',
        annotations: {
            ['kubernetes.io/ingress.class']: 'traefik',
        },
    },
    spec: {
        rules: [{
            host: config.domain,
            http: {
                paths: [{
                    path: '/',
                    pathType: 'Prefix',
                    backend: {
                        service: {
                            name: name + '-service',
                            port: {
                                number: config.port
                            }
                        }
                    }
                }]
            }
        }]
    }
};

{
    App(name, config):: {
        ['apps/' + name + '/' + name + '-deployment.json']: Deployment(name, config),
        ['apps/' + name + '/' + name + '-service.json']: Service(name, config),
        ['apps/' + name + '/' + name + '-ingress.json']: Ingress(name, config),
    }
}
