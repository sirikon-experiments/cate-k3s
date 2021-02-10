local u = import 'utils.libsonnet';
{}

+u.App("nginx-test", {
    domain: 'cate.srk.bz',
    image: 'nginx:1.19',
    port: 80
})
