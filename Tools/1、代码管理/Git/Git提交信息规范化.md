# Git提交信息规范化

## 目的

+ 统一团队Git Commit标准，便于后续代码review、版本发布、自动化生成change log；
+ 可以提供更多更有效的历史信息，方便代码复用，方便快速预览以及配合cherry-pick快速合并代码；
+ 团队其他成员进行类git blame时可以快速明白代码用意；

## Git版本规范

### 分支

+ master分支为主分支(保护分支)，不能直接在master上进行修改代码和提交；
+ develop分支为测试分支，所以开发完成需要提交测试的功能合并到该分支，用来发布日常版本交给测试进行测试；
+ release 分支为线上分支，用来发布线上版本，并打tag；从develop 分支拉出；release 分支的代码需要定期合并到master 上；
+ feature分支为开发分支，大家根据不同需求创建独立的功能分支，开发完成后合并到develop分支；
+ fix分支为bug修复分支，需要根据实际情况对已发布的版本进行漏洞修复，合并到release分支上；

### Tag

采用三段式，v里程碑_code_序号，如v1.2.1

+ 架构升级或架构重大调整，修改第1位
+ 新功能上线或者模块大的调整，修改第1位
+ bug修复上线，修改第3位

### changelog

版本正式发布后，需要生产changelog文档，便于后续问题追溯。

## Git提交信息

git 的 commitmessage信息格式采用目前主流的`Angular规范`，这是目前使用最广的写法，比较合理和系统化，并且有配套的工具。

![](./res/2018051117492049.jpeg)

### commit message格式说明

Commit message一般包括三部分：Header、Body和Footer。

#### Header

`type(scope):subject`

+ type：用于说明commit的类别，规定为如下几种
    + feat：新增功能；
    + fix：修复bug；
    + docs：修改文档；
    + refactor：代码重构，未新增任何功能和修复任何bug；
    + build：改变构建流程，新增依赖库、工具等（例如webpack修改）；
    + style：仅仅修改了空格、缩进等，不改变代码逻辑；
    + perf：改善性能和体现的修改；
    + chore：非src和test的修改；
    + test：测试用例的修改；
    + ci：自动化流程配置修改；
    + revert：回滚到上一个版本；
+ scope：【可选】用于说明commit的影响范围
+ subject：commit的简要说明，尽量简短 (72字符)

#### Body

+ 对本次commit的详细描述，可分多行
+ 永远别忘了第2行是空行
+ 应该说明代码变动的动机，以及与以前行为的对比。


#### Footer

+ 关闭指定Issue：输入Issue信息（id或者url）

#### 实例 一

```
 fix(ivy): reuse compilation scope for incremental template changes. 

Previously if only a component template changed then we would know to
rebuild its component source file. But the compilation was incorrect if the
component was part of an NgModule, since we were not capturing the
compilation scope information that had a been acquired from the NgModule
and was not being regenerated since we were not needing to recompile
the NgModule.

Now we register compilation scope information for each component, via the
`ComponentScopeRegistry` interface, so that it is available for incremental
compilation.

The `ComponentDecoratorHandler` now reads the compilation scope from a
`ComponentScopeReader` interface which is implemented as a compound
reader composed of the original `LocalModuleScopeRegistry` and the
`IncrementalState`.

Fixes #31654

PR Close #31932
```

#### 实例 二

```
 refactor(core): move renderer2 migration lint rule into google3 folder (#31817)

Moves the `renderer_to_renderer2` migration google3 tslint rule
into the new `google3` directory. This is done for consistency
as we recently moved all google3 migration rules into a new
`google3` folder (see: f69e4e6).

PR Close #31817
```

#### 实例三
```
docs(router): rename incorrect class names (#31815)

PR Close #31815
```
