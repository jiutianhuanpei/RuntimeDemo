#runtimeDemo

对rumtime的一些简单应用。

###一、关联方法

```
/**
 *  Hook 一个方法
 *
 *  @param class1    需要 Hook 的方法所在的类
 *  @param selector1 需要 Hook 的方法
 *  @param class2    关联的方法所在的类
 *  @param selector2 关联的方法
 */
void AssociateWithSelector(Class class1, SEL selector1, Class class2, SEL selector2);
```

用处：统一对一个方法做某些操作、或者要hook一个方法时可以用，比如在 `UIViewController` 的扩展里关联 `- (void)viewWillAppear;`。 又或者在一个类里hook `AppDelegate`里的方法获取token。


<br>

###二、打印对象 

```
/**
 *  打印对象为json
 *
 *  @param object 要打印的对象
 */
void SHBLogObject(id object);
```
用处：把一个对象打印为字典格式。
