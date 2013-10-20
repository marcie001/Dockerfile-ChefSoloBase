# knife solo prepare foo までの準備ができたイメージを作る
# http://d.hatena.ne.jp/naoya/20130620/1371729625 を参考にした
#
# VERSION 0.2
FROM centos

MAINTAINER marcie001, marcie00001@gmail.com

# install packages
RUN yum install -y openssh-server openssh-clients sudo passwd

# create user
# ホストとのファイル共有のためにホストとuid, gid を合わせた
RUN groupadd -g 1000 marcie
RUN useradd -m -d /home/marcie -u 1000 -g 1000 marcie
RUN passwd -f -u marcie
RUN mkdir /home/marcie/.ssh
RUN chown marcie:marcie /home/marcie/.ssh
RUN chmod 700 /home/marcie/.ssh
ADD authorized_keys /home/marcie/.ssh/authorized_keys
RUN chown marcie:marcie /home/marcie/.ssh/authorized_keys
RUN chmod 600 /home/marcie/.ssh/authorized_keys

# sudoers
RUN echo "marcie    ALL=(ALL)       ALL" >> /etc/sudoers.d/marcie

# sshd
ADD sshd_config /etc/ssh/sshd_config
# generate host keys
RUN /etc/init.d/sshd start
RUN /etc/init.d/sshd stop

# entrypoint
ENTRYPOINT ["/usr/sbin/sshd", "-D"]
EXPOSE 49222:22
