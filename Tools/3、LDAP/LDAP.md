# LDAP

（http://www.ldap.org.cn/）
（https://www.howtoing.com/how-to-install-and-configure-openldap-and-phpldapadmin-on-ubuntu-16-04/）

LDAP是轻量目录访问协议，英文全称是LIGHTWEIGHT DIRECTORY ACCESS PROTOCOL，一般都简称为LDAP。

`当前多种开源系统都加入了LDAP的支持，比如：Gerrit、Gitlab、Jenkins、Redmine……`

## 描述

### 优点

+ `读写效率非常高`：对读操作进行优化的一种数据库，在读写比例大于7比1的情况下，LDAP会体现出极高的性能。这个特性正适合了身份认证的需要。
+ `开放的标准协议`：不同于SQL数据库，LDAP的客户端是跨平台的，并且对几乎所有的程序语言都有标准的API接口。即使是改变了LDAP数据库产品的提供厂商，开发人员也不用担心需要修改程序才能适应新的数据库产品。这个优势是使用SQL语言进行查询的关系型数据库难以达到的。
+ `强认证方式` ： 可以达到很高的安全级别。在国际化方面，LDAP使用了UTF-8编码来存储各种语言的字符。
+ `OpenLDAP开源实现`：OpenLDAP还包含了很多有创造性的新功能，能满足大多数使用者的要求。笔者曾使用过许多商用LDAP产品，OpenLDAP是其中最轻便且消耗系统资源最少的一个。OpenLDAP是开源软件，近年国内很多公司开发的LDAP产品都是基于OpenLDAP开发的。
+ `灵活添加数据类型`：LDAP是根据schema的内容定义各种属性之间的从属关系及匹配模式的。例如在关系型数据库中如果要为用户增加一个属性，就要在用户表中增加一个字段，在拥有庞大数量用户的情况下是十分困难的，需要改变表结构。但LDAP只需要在schema中加入新的属性，不会由于用户的属性增多而影响查询性能
+ `数据存储是树结构`：整棵树的任何一个分支都可以单独放在一个服务器中进行分布式管理，不仅有利于做服务器的负载均衡，还方便了跨地域的服务器部署。这个优势在查询负载大或企业在不同地域都设有分公司的时候体现尤为明显

### 特点

1. LDAP 是一种网络协议而不是数据库，而且LDAP的目录不是关系型的，没有RDBMS那么复杂， 
2. LDAP不支持数据库的Transaction机制，纯粹的无状态、请求-响应的工作模式。 
3. LDAP不能存储BLOB，LDAP的读写操作是非对称的，读非常方便，写比较麻烦， 
4. LDAP支持复杂的查询过滤器(filter)，可以完成很多类似数据库的查询功能。 
5. LDAP使用树状结构，接近于公司组织结构、文件目录结构、域名结构等我们耳熟能详的东东。 LDAP使用简单、接口标准，并支持SSL访问。

### LDAP与NIS相比

1. LDAP是标准的、跨平台的，在Windows下也能支持。 
2. LDAP支持非匿名的访问，而且有比较复杂的访问控制机制(如ACL)，安全性似乎更好一些。 
3. LDAP支持很多复杂的查询方式。 
4. LDAP的用途较NIS更为广泛，各种服务都可以和LDAP挂钩。

### LDAP的主要应用场景

1. 网络服务：DNS服务 
2. 统一认证服务： 
3. Linux PAM (ssh, login, cvs. . . ) 
4. Apache访问控制 
5. 各种服务登录(ftpd, php based, perl based, python based. . . ) 
6. 个人信息类，如地址簿 
7. 服务器信息，如帐号管理、邮件服务等

## 安装和配置LDAP服务器

### 安装

```
sudo apt-get update
sudo apt-get install slapd ldap-utils
```

在安装过程中，将要求您选择并确认LDAP的管理员密码。 您可以在这里输入任何内容，因为您将有机会在短时间内进行更新。

即使我们刚刚安装了这个软件包，我们也要进行重新配置。 slapd软件包有能力提出很多重要的配置问题，但默认情况下，它们将在安装过程中跳过。 通过告诉我们的系统重新配置包，我们可以访问所有提示：

```
sudo dpkg-reconfigure slapd
```

+ 省略了OpenLDAP服务器配置？ `没有`
+ DNS域名？
    + 此选项将确定目录路径的基本结构。 阅读消息以了解这将如何实现。 即使您不拥有实际的网域，您也可以选择所需的任何值。 但是，本教程假设您具有适当的服务器域名，因此您应该使用它。 我们将在整个教程中使用example.com 。
+ 机构名称？
    + 对于本指南，我们将使用示例作为我们组织的名称。 你可以选择任何你觉得合适的东西。
+ 管理员密码？ ` 输入两次安全密码    `
+ 数据库后端？  `MDB`
+ 清除slapd时删除数据库？ `没有`
+ 移动旧数据库？ `是`
+ 允许LDAPv2协议？ `没有`

打开防火墙上的LDAP端口，以便外部客户端可以连接：

```
sudo ufw allow ldap
```

测试我们与ldapwhoami的LDAP连接，该连接应该返回我们连接的用户名：

```
ldapwhoami -H ldap:// -x
anonymous
```

### phpLDAPadmin

Ubuntu存储库包含一个phpLDAPadmin软件包。 使用apt-get安装它：

```
sudo apt-get install phpldapadmin
```

首先在文本编辑器中打开具有root权限的主配置文件：

```
sudo vi /etc/phpldapadmin/config.php

```

寻找以$servers->setValue('server','name'开头的行；该行是LDAP服务器的显示名称，Web界面用于有关服务器的标题和消息。

```
$servers->setValue('server','name','Example LDAP');
```

$servers->setValue('server','base'行，该配置告诉phpLDAPadmin LDAP层次结构的根目录，这是基于我们在重新配置slapd包时输入的值。我们的示例我们选择了example.com ，我们需要将每个域组件（不是一个点）放入dc= notation中将其转换为LDAP语法：


```
$servers->setValue('server','base', array('dc=example,dc=com'));
```
现在找到登录bind_id配置行，并bind_id开头注释#

```
#$servers->setValue('login','bind_id','cn=admin,dc=example,dc=com');
```
此选项预先填充Web界面中的管理员登录详细信息。 这是我们不能共享的信息，如果我们的phpLDAPadmin页面是可公开访问的。

最后一件事是控制一些phpLDAPadmin警告消息的可见性的设置。 默认情况下，应用程序将显示相当多的关于模板文件的警告消息。 这些对我们目前使用的软件没有影响。 我们可以通过搜索hide_template_warning参数来隐藏它们，取消注释包含它的行，并将其设置为true ：

```
$config->custom->appearance['hide_template_warning'] = true;
```

### 登录到phpLDAPadmin Web界面

将必要的配置更改为phpLDAPadmin后，我们现在可以开始使用它了。 浏览您的网页浏览器中的应用程序。 请务必将您的域替换为以下突出显示的区域：

```
https://example.com/phpldapadmin
```

登录DN是您将要使用的用户名。 它包含帐户名称作为cn=部分，您为服务器选择的域名分为dc=部分，如上述步骤所述。 我们在安装过程中设置的默认管理员帐户称为admin ，因此在我们的示例中，我们将键入以下内容：

```
cn=admin,dc=example,dc=com
```
为您的域输入适当的字符串后，键入您在配置期间创建的管理员密码，然后单击验证按钮。

您将被带到主界面：

您将登录到phpLDAPadmin界面。 您可以添加用户，组织单位，组和关系。

### 配置StartTLS LDAP加密

## ldap 自助密码修改程序 self-service-password

https://ltb-project.org/doku.php

(基本上，配置一遍，就知道是怎么回事了)
