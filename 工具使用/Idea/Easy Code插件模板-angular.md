# IntelliJ IDEA插件-Easy Code

Easy Code是一款根据数据库结构`自动生成代码`的IDEA插件

插件使用可参考：[IntelliJ IDEA中插件EasyCode 的安装及使用过程](https://blog.csdn.net/suprezheng/article/details/84558689)

## Easy Code模板添加

Easy Code默认提供Default、MybatisPlus俩套模板，却没有关于JPA的模板，但是Easy Code支持模板添加，方式如下图：

![](E:/myfile/notes/工具使用/Idea/media/easy_code_set.png)

## Angular模板

### 添加 Global Config

在Settings > OtherSettings > Easy Code > Global Config中添加angularDefine

```java
##（Velocity宏定义）

##定义设置表名后缀的宏定义，调用方式：#setTableSuffix("Test")
#macro(setTableSuffix $suffix)
    #set($tableName = $!tool.append($tableInfo.name, $suffix))
#end

##定义设置包名后缀的宏定义，调用方式：#setPackageSuffix("Test")
#macro(setPackageSuffix $suffix)
#if($suffix!="")package #end#if($tableInfo.savePackageName!="")$!{tableInfo.savePackageName}.#{end}$!suffix;
#end

##定义直接保存路径与文件名简化的宏定义，调用方式：#save("/entity", ".java")
#macro(save $path $fileName)
    $!callback.setSavePath($tool.append($tableInfo.savePath, $path))
    $!callback.setFileName($tool.append($!tool.firstLowerCase($!{tableInfo.name}), $fileName))
#end

##定义表注释的宏定义，调用方式：#tableComment("注释信息")
#macro(tableComment $desc)
/**
 * $!{tableInfo.comment}($!{tableInfo.name})$desc
 *
 * @author $!author
 * @since $!time.currTime()
 */
#end

##定义GET，SET方法的宏定义，调用方式：#getSetMethod($column)
#macro(getSetMethod $column)

    public $!{tool.getClsNameByFullName($column.type)} get$!{tool.firstUpperCase($column.name)}() {
        return $!{column.name};
    }

    public void set$!{tool.firstUpperCase($column.name)}($!{tool.getClsNameByFullName($column.type)} $!{column.name}) {
        this.$!{column.name} = $!{column.name};
    }
#end
```

### 添加Type Mapper

在Settings > OtherSettings > Easy Code > Type Mapper中添加angular

| columeType     | javaType  |
| --------------------- | ------- |
| varchar(\(\d+\))?     | string  |
| char(\(\d+\))?        | string  |
| text                  | string  |
| decimal(\(\d+\))?     | number  |
| decimal(\(\d+,\d+\))? | number  |
| integer               | number  |
| int(\(\d+\))?         | number  |
| int4                  | number  |
| int8                  | number  |
| bigint(\(\d+\))?      | number  |
| datetime              | string  |
| timestamp             | string  |
| boolean               | boolean |
| bit(\(\d+\))?         | boolean |
| float                 | number  |

### 添加Template Setting

#### module.ts

```typescript
##引入宏定义
$!angularDefine

##使用宏定义设置回调（保存位置与文件后缀）
#save("/$!tool.firstLowerCase($!{tableInfo.name})", ".module.ts")

##使用宏定义实现类注释信息
##tableComment("实体类")

import {NgModule} from '@angular/core';

import {$!{tableInfo.name}RoutingModule} from './$!tool.firstLowerCase($!{tableInfo.name})-routing.module';
import {SharedModule} from '../../shared/shared.module';
import {$!{tableInfo.name}CreateComponent} from './$!tool.firstLowerCase($!{tableInfo.name})-create/$!tool.firstLowerCase($!{tableInfo.name})-create.component';
import {$!{tableInfo.name}UpdateComponent} from './$!tool.firstLowerCase($!{tableInfo.name})-update/$!tool.firstLowerCase($!{tableInfo.name})-update.component';
import {$!{tableInfo.name}ListComponent} from './$!tool.firstLowerCase($!{tableInfo.name})-list/$!tool.firstLowerCase($!{tableInfo.name})-list.component';

@NgModule({
  declarations: [$!{tableInfo.name}CreateComponent, $!{tableInfo.name}UpdateComponent, $!{tableInfo.name}ListComponent],
  imports: [
    SharedModule,
    $!{tableInfo.name}RoutingModule
  ]
})
export class $!{tableInfo.name}Module {
}
```

#### routing.module.ts

```typescript
##引入宏定义
$!angularDefine

##使用宏定义设置回调（保存位置与文件后缀）
#save("/$!tool.firstLowerCase($!{tableInfo.name})", "-routing.module.ts")

##使用宏定义实现类注释信息
##tableComment("实体类")

import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { $!{tableInfo.name}ListComponent } from './$!tool.firstLowerCase($!{tableInfo.name})-list/$!tool.firstLowerCase($!{tableInfo.name})-list.component';

const routes: Routes = [
  {path: '', component: $!{tableInfo.name}ListComponent},
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class $!{tableInfo.name}RoutingModule { }
```

#### service.ts

```typescript
##引入宏定义
$!angularDefine

##使用宏定义设置回调（保存位置与文件后缀）
#save("/$!tool.firstLowerCase($!{tableInfo.name})", ".service.ts")

import {Injectable} from '@angular/core';
import {Observable} from 'rxjs';
import {HttpClient, HttpHeaders} from '@angular/common/http';
import {$!{tableInfo.name}} from '../../domain/$!tool.append($!tool.firstLowerCase($!{tableInfo.name}),".model")';

const httpOptions = {
  headers: new HttpHeaders({'Content-Type': 'application/json'})
};

@Injectable({
  providedIn: 'root'
})
export class $!{tableInfo.name}Service {

  constructor(private http: HttpClient) {
  }


  /**
   * 创建$!{tableInfo.comment}
   *
   * @param $!tool.firstLowerCase($!{tableInfo.name}) $!{tableInfo.comment}
   * @return $!{tableInfo.comment}
   */
  create$!{tableInfo.name}($!tool.firstLowerCase($!{tableInfo.name}): $!{tableInfo.name}): Observable<any> {
    const url = '/mo/v1/$!tool.firstLowerCase($!{tableInfo.name})';
    return this.http.post(url, JSON.stringify($!tool.firstLowerCase($!{tableInfo.name})), httpOptions);
  }

  /**
   * 删除$!{tableInfo.comment}
   *
   * @param id $!{tableInfo.comment}的id
   */
  delete$!{tableInfo.name}(id: string): Observable<any> {
    const url = '/mo/v1/$!tool.firstLowerCase($!{tableInfo.name})/' + id;
    return this.http.delete(url);
  }

  /**
   * 获取$!{tableInfo.comment}列表
   *
   * @return $!{tableInfo.comment}列表
   */
  list$!{tableInfo.name}s(): Observable<$!{tableInfo.name}[]> {
    const url = '/mo/v1/$!tool.firstLowerCase($!{tableInfo.name})';
    return this.http.get<$!{tableInfo.name}[]>(url);
  }

  /**
   * 获取$!{tableInfo.comment}
   *
   * @param id $!{tableInfo.comment}的id
   * @return $!{tableInfo.comment}
   */
  get$!{tableInfo.name}(id: string): Observable<$!{tableInfo.name}> {
    const url = '/mo/v1/$!tool.firstLowerCase($!{tableInfo.name})/' + id;
    return this.http.get<$!{tableInfo.name}>(url);
  }

  /**
   * 更新$!{tableInfo.comment}
   *
   * @param id $!{tableInfo.comment}的id
   * @param $!tool.firstLowerCase($!{tableInfo.name}) $!{tableInfo.comment}
   * @return $!{tableInfo.comment}
   */
  update$!{tableInfo.name}(id: string, $!tool.firstLowerCase($!{tableInfo.name}): $!{tableInfo.name}): Observable<$!{tableInfo.name}> {
    const url = '/mo/v1/$!tool.firstLowerCase($!{tableInfo.name})/' + id;
    return this.http.put<$!{tableInfo.name}>(url, JSON.stringify($!tool.firstLowerCase($!{tableInfo.name})), httpOptions);
  }

}
```

#### model.ts

```typescript
##引入宏定义
$!angularDefine

##使用宏定义设置回调（保存位置与文件后缀）
#save("/domain", ".model.ts")

##使用宏定义实现类注释信息
#tableComment("模型")
export interface $!{tableInfo.name} {

#foreach($column in $tableInfo.fullColumn)
  #if(${column.comment})/**
    * ${column.comment}
    */#end

  $!{column.name}?: $!{tool.getClsNameByFullName($column.type)};
#end
}
```

#### create.component.ts

```typescript
##引入宏定义
$!angularDefine

##使用宏定义设置回调（保存位置与文件后缀）
#save("/$!tool.firstLowerCase($!{tableInfo.name})/$!tool.firstLowerCase($!{tableInfo.name})-create", "-create.component.ts")

import {Component, Input, OnInit} from '@angular/core';
import {FormBuilder, FormGroup, Validators} from '@angular/forms';
import {$!{tableInfo.name}} from '../../../domain/$!tool.append($!tool.firstLowerCase($!{tableInfo.name}),".model")';
import {FormUtil} from '../../../utils/form.util';

@Component({
  selector: 'app-$!tool.firstLowerCase($!{tableInfo.name})-create',
  templateUrl: './$!tool.firstLowerCase($!{tableInfo.name})-create.component.html',
  styleUrls: ['./$!tool.firstLowerCase($!{tableInfo.name})-create.component.css']
})
export class $!{tableInfo.name}CreateComponent implements OnInit {

  @Input() data?: any;

  validateForm!: FormGroup;

  constructor(
    private fb: FormBuilder,
    private formUtil: FormUtil
  ) {
  }

  ngOnInit(): void {
    this.validateForm = this.fb.group({
#foreach($column in $tableInfo.otherColumn)
  $!{column.name}: [null, [Validators.required]],
#end
    });
  }

  /**
   * 校验表单
   */
  isValidForm(): boolean {
    return this.formUtil.isValidForm(this.validateForm);
  }

  /**
   * 获取表单数据并进行处理
   */
  getFormData(): $!{tableInfo.name} {
    let data: $!{tableInfo.name} = {};
    data = this.formUtil.getFormData(data, this.validateForm);
    return data;
  }

}
```

#### create.component.html

```html
##引入宏定义
$!angularDefine

##使用宏定义设置回调（保存位置与文件后缀）
#save("/$!tool.firstLowerCase($!{tableInfo.name})/$!tool.firstLowerCase($!{tableInfo.name})-create", "-create.component.html")

<form nz-form [formGroup]="validateForm">

#foreach($column in $tableInfo.otherColumn)
  <nz-form-item>
    <nz-form-label [nzSm]="6" [nzXs]="24" nzFor="$!{column.name}" nzRequired>$!{column.comment}</nz-form-label>
    <nz-form-control [nzSm]="14" [nzXs]="24" nzHasFeedback [nzErrorTip]="$!{column.name}ErrorTpl">

      <input nz-input id="$!{column.name}" formControlName="$!{column.name}"/>
      <ng-template #$!{column.name}ErrorTpl let-control>
        <ng-container *ngIf="control.hasError('required')">
          请输入${column.comment}!
        </ng-container>
        <ng-container *ngIf="control.hasError('pattern')">
          只能包含中文、数字、字母和特殊字符中的"-"
        </ng-container>
        <ng-container *ngIf="control.hasError('maxlength')">
          长度过长
        </ng-container>
      </ng-template>

    </nz-form-control>
  </nz-form-item>
  
#end

</form>
```

#### create.component.css

```typescript
##引入宏定义
$!angularDefine

##使用宏定义设置回调（保存位置与文件后缀）
#save("/$!tool.firstLowerCase($!{tableInfo.name})/$!tool.firstLowerCase($!{tableInfo.name})-create", "-create.component.css")
```

#### update.component.ts

```typescript
##引入宏定义
$!angularDefine

##使用宏定义设置回调（保存位置与文件后缀）
#save("/$!tool.firstLowerCase($!{tableInfo.name})/$!tool.firstLowerCase($!{tableInfo.name})-update", "-update.component.ts")

import {Component, Input, OnInit} from '@angular/core';
import {FormBuilder, FormGroup, Validators} from '@angular/forms';
import {NzModalRef} from 'ng-zorro-antd';
import {$!{tableInfo.name}} from '../../../domain/$!tool.append($!tool.firstLowerCase($!{tableInfo.name}),".model")';
import {FormUtil} from '../../../utils/form.util';

@Component({
  selector: 'app-$!tool.firstLowerCase($!{tableInfo.name})-update',
  templateUrl: './$!tool.firstLowerCase($!{tableInfo.name})-update.component.html',
  styleUrls: ['./$!tool.firstLowerCase($!{tableInfo.name})-update.component.css']
})
export class $!{tableInfo.name}UpdateComponent implements OnInit {

  @Input() data?: $!{tableInfo.name};

  validateForm!: FormGroup;

  constructor(private fb: FormBuilder,
              private formUtil: FormUtil,
              private modal: NzModalRef) {
  }

  ngOnInit(): void {
    this.validateForm = this.fb.group({
#foreach($column in $tableInfo.otherColumn)
  $!{column.name}: [this.data.$!{column.name}, [Validators.required]],
#end
    });
  }


  isValidForm(): boolean {
    return this.formUtil.isValidForm(this.validateForm);
  }


  getFormData(): $!{tableInfo.name} {
    const data: $!{tableInfo.name} = this.formUtil.getFormData(this.data, this.validateForm);
    return data;
  }

}
```

#### update.component.html

```html
##引入宏定义
$!angularDefine

##使用宏定义设置回调（保存位置与文件后缀）
#save("/$!tool.firstLowerCase($!{tableInfo.name})/$!tool.firstLowerCase($!{tableInfo.name})-update", "-update.component.html")

<form nz-form [formGroup]="validateForm">

#foreach($column in $tableInfo.otherColumn)
  <nz-form-item>
    <nz-form-label [nzSm]="6" [nzXs]="24" nzFor="$!{column.name}" nzRequired>$!{column.comment}</nz-form-label>
    <nz-form-control [nzSm]="14" [nzXs]="24" nzHasFeedback [nzErrorTip]="$!{column.name}ErrorTpl">

      <input nz-input id="$!{column.name}" formControlName="$!{column.name}"/>
      <ng-template #$!{column.name}ErrorTpl let-control>
        <ng-container *ngIf="control.hasError('required')">
          请输入${column.comment}!
        </ng-container>
        <ng-container *ngIf="control.hasError('pattern')">
          只能包含中文、数字、字母和特殊字符中的"-"
        </ng-container>
        <ng-container *ngIf="control.hasError('maxlength')">
          长度过长
        </ng-container>
      </ng-template>

    </nz-form-control>
  </nz-form-item>
  
#end

</form>
```

#### update.component.css

```css
##引入宏定义
$!angularDefine

##使用宏定义设置回调（保存位置与文件后缀）
#save("/$!tool.firstLowerCase($!{tableInfo.name})/$!tool.firstLowerCase($!{tableInfo.name})-update", "-update.component.css")
```

#### list.component.ts

```typescript
##引入宏定义
$!angularDefine

##使用宏定义设置回调（保存位置与文件后缀）
#save("/$!tool.firstLowerCase($!{tableInfo.name})/$!tool.firstLowerCase($!{tableInfo.name})-list", "-list.component.ts")

import {Component, OnInit, ViewContainerRef} from '@angular/core';
import {$!{tableInfo.name}} from '../../../domain/$!tool.append($!tool.firstLowerCase($!{tableInfo.name}),".model")';
import {$!{tableInfo.name}Service} from '../$!tool.append($!tool.firstLowerCase($!{tableInfo.name}),".service")';
import {$!{tableInfo.name}CreateComponent} from '../$!tool.firstLowerCase($!{tableInfo.name})-create/$!tool.firstLowerCase($!{tableInfo.name})-create.component';
import {$!{tableInfo.name}UpdateComponent} from '../$!tool.firstLowerCase($!{tableInfo.name})-update/$!tool.firstLowerCase($!{tableInfo.name})-update.component';
import {NzMessageService} from 'ng-zorro-antd';
import {NzModalService} from 'ng-zorro-antd/modal';

@Component({
  selector: 'app-$!tool.firstLowerCase($!{tableInfo.name})-list',
  templateUrl: './$!tool.firstLowerCase($!{tableInfo.name})-list.component.html',
  styleUrls: ['./$!tool.firstLowerCase($!{tableInfo.name})-list.component.css']
})
export class $!{tableInfo.name}ListComponent implements OnInit {

  listOfData: $!{tableInfo.name}[];

  constructor(private service: $!{tableInfo.name}Service,
              private modal: NzModalService,
              private message: NzMessageService,
              private viewContainerRef: ViewContainerRef) {
  }

  ngOnInit(): void {
    this.list$!{tableInfo.name}s();
  }


  /**
   * 创建添加对话框
   */
  createAddModal(): void {

    const modal = this.modal.create({
      nzTitle: '添加$!{tableInfo.comment}',
      nzContent: $!{tableInfo.name}CreateComponent,
      nzViewContainerRef: this.viewContainerRef,
      nzComponentParams: {
        data: '',
      },
      nzOnOk: (componentInstance: $!{tableInfo.name}CreateComponent) => {
        const isValid: boolean = componentInstance.isValidForm();
        if (isValid) {
          const result: $!{tableInfo.name} = componentInstance.getFormData();
          this.create$!{tableInfo.name}(result);
          return result;
        }
        return false;
      }

    });
    modal.afterOpen.subscribe(() => console.log('[afterOpen] emitted!'));
    // Return a result when closed
    modal.afterClose.subscribe(result => {
      console.log('[afterClose] The result is:', result);
    });

  }

  /**
   * 创建编辑对话框
   */
  createEditModal($!tool.firstLowerCase($!{tableInfo.name}): any): void {

    const modal = this.modal.create({
      nzTitle: '编辑$!{tableInfo.comment}',
      nzContent: $!{tableInfo.name}UpdateComponent,
      nzViewContainerRef: this.viewContainerRef,
      nzComponentParams: {
        data: $!tool.firstLowerCase($!{tableInfo.name}),
      },
      nzOnOk: (componentInstance: $!{tableInfo.name}UpdateComponent) => {
        const isValid: boolean = componentInstance.isValidForm();
        if (isValid) {
          const result: $!{tableInfo.name} = componentInstance.getFormData();
          this.update$!{tableInfo.name}(result.id, result);
          return result;
        }
        return false;
      }
    });
    modal.afterOpen.subscribe(() => console.log('[afterOpen] emitted!'));
    // Return a result when closed
    modal.afterClose.subscribe(result => console.log('[afterClose] The result is:', result));
  }

  /**
   * 创建删除对话框
   * @param $!tool.firstLowerCase($!{tableInfo.name}) 待删除的$!{tableInfo.comment}
   */
  createDeleteModal($!tool.firstLowerCase($!{tableInfo.name}): $!{tableInfo.name}): void {

    const modal = this.modal.confirm({
      nzTitle: '删除$!{tableInfo.comment}',
      nzContent: '确定删除$!{tableInfo.comment}" ' + $!tool.append($!tool.firstLowerCase($!{tableInfo.name}),".name") + ' "吗？',
      nzOnOk: () => {
        this.delete$!{tableInfo.name}($!tool.append($!tool.firstLowerCase($!{tableInfo.name}),".id"));
      }
    });
    modal.afterOpen.subscribe(() => console.log('[afterOpen] emitted!'));
    // Return a result when closed
    modal.afterClose.subscribe(result => console.log('[afterClose] The result is:', result));
  }


  /**
   * 调用后台api创建$!{tableInfo.comment}
   * @param $!tool.firstLowerCase($!{tableInfo.name}) $!{tableInfo.comment}
   */
  create$!{tableInfo.name}($!tool.firstLowerCase($!{tableInfo.name}): $!{tableInfo.name}): void {
    const messageId = this.message.loading('正在创建中...', {nzDuration: 0}).messageId;
    this.service.create$!{tableInfo.name}($!tool.firstLowerCase($!{tableInfo.name})).subscribe(
      (data) => {
        console.log(data);
        this.refreshData();
        this.message.success('创建成功！');
        this.message.remove(messageId);
      },
      (error) => {
        console.error(error);
        this.message.error('创建失败！');
        this.message.remove(messageId);
      });
  }

  /**
   * 调用后台api获取$!{tableInfo.comment}列表
   */
  list$!{tableInfo.name}s(): void {
    const messageId = this.message.loading('正在获取中...', {nzDuration: 0}).messageId;
    this.service.list$!{tableInfo.name}s().subscribe(
      (data) => {
        this.message.remove(messageId);
        this.message.success('获取成功！');
        this.listOfData = data;
      },
      (error) => {
        console.log('error: ' + error);
        this.message.error('获取失败！');
        this.message.remove(messageId);
      }
    );
  }

  /**
   * 调用后台api删除$!{tableInfo.comment}
   * @param id $!{tableInfo.comment}id
   */
  delete$!{tableInfo.name}(id: string): void {
    const messageId = this.message.loading('正在删除中...', {nzDuration: 0}).messageId;
    this.service.delete$!{tableInfo.name}(id).subscribe(
      (data) => {
        console.log('next: ' + data);
        this.message.remove(messageId);
        this.message.success('删除成功！');
        this.refreshData();
      },
      (error) => {
        console.log('error: ' + error);
        this.message.error('删除失败！');
        this.message.remove(messageId);
      }
    );
  }

  /**
   * 调用后台api更新$!{tableInfo.comment}
   * @param id $!{tableInfo.comment}id
   * @param updateData 更新数据
   */
  update$!{tableInfo.name}(id: string, updateData: $!{tableInfo.name}): void {
    const messageId = this.message.loading('正在更新中...', {nzDuration: 0}).messageId;
    this.service.update$!{tableInfo.name}(id, updateData).subscribe(
      (data) => {
        console.log('next: ' + data);
        this.message.remove(messageId);
        this.message.success('更新成功！');
        this.refreshData();
      },
      (error) => {
        console.log('error: ' + error);
        this.message.error('更新失败！');
        this.message.remove(messageId);
      }
    );
  }

  /**
   * 刷新数据
   */
  refreshData(): void {
    this.list$!{tableInfo.name}s();
  }

}
```

#### list.component.html

```html
##引入宏定义
$!angularDefine

##使用宏定义设置回调（保存位置与文件后缀）
#save("/$!tool.firstLowerCase($!{tableInfo.name})/$!tool.firstLowerCase($!{tableInfo.name})-list", "-list.component.html")

<div class="table-operations">
  <!--  add button start-->
  <button nz-button nzType="primary" (click)="createAddModal()">
    <span><i nz-icon nzType="plus" nzTheme="outline"></i> $!{tableInfo.comment}</span>
  </button>
  <!--  add button end-->

  <div class="pull-right">
    <!--    search bar start-->
    <nz-input-group nzSearch [nzAddOnAfter]="suffixIconButton" style="width:220px">
      <input type="text" nz-input placeholder="input search text"/>
    </nz-input-group>
    <ng-template #suffixIconButton>
      <button nz-button nzType="primary" nzSearch><i nz-icon nzType="search"></i></button>
    </ng-template>
    <!--    search bar end-->

    <!--    refresh button start-->
    <button nz-button nzType="primary" (click)="refreshData()" class="table-top-opt" nz-popover [nzContent]="'刷新'">
      <i nz-icon nzType="reload"></i>
    </button>
    <!--    refresh button end-->
  </div>

</div>


<!--list start-->
<nz-table #basicTable [nzData]="listOfData">
  <thead>
  <tr>
#foreach($column in $tableInfo.otherColumn)
    <th>$!{column.comment}</th>
#end
    <th>操作</th>
  </tr>
  </thead>
  <tbody>
  <tr *ngFor="let data of basicTable.data">
#foreach($column in $tableInfo.otherColumn)
    <td>{{ data.$!{column.name} }}</td>
#end
    <td>
      <a (click)="createEditModal(data)">更新</a>
      <nz-divider nzType="vertical"></nz-divider>
      <a (click)="createDeleteModal(data)">删除</a>
    </td>
  </tr>
  </tbody>
</nz-table>
<!--list end-->
```

#### list.component.css

```css
##引入宏定义
$!angularDefine

##使用宏定义设置回调（保存位置与文件后缀）
#save("/$!tool.firstLowerCase($!{tableInfo.name})/$!tool.firstLowerCase($!{tableInfo.name})-list", "-list.component.css")

.table-operations {
  margin-bottom: 16px;
}

.table-operations > button {
  margin-right: 8px;
}

.pull-left {
  float: left !important;
}

.pull-right {
  float: right !important;
}

.pull-right .table-top-opt {
  margin-left: 3px;
  font-size: 14px;
}
```

注意：由于每个人对代码模板的要求不同，以上内容仅作参考，请根据自身需求制定。





## Angular模板后期变更（2020-12-01）

变更内容：添加搜索功能，添加分页查询

### list.component.html

```html
##引入宏定义
$!angularDefine

##使用宏定义设置回调（保存位置与文件后缀）
#save("/$!tool.firstLowerCase($!{tableInfo.name})/$!tool.firstLowerCase($!{tableInfo.name})-list", "-list.component.html")

<div class="table-operations">
  <!--  add button start-->
  <button nz-button nzType="primary" (click)="createAddModal()">
    <span><i nz-icon nzType="plus" nzTheme="outline"></i> $!{tableInfo.comment}</span>
  </button>
  <!--  add button end-->

  <div class="pull-right">
    <!--    search bar start-->
    <nz-input-group nzSearch [nzAddOnAfter]="suffixIconButton" style="width:220px">
      <input nz-input type="text" [(ngModel)]="queryParamValue" (keyup)="onKey($event)"  placeholder="input search text"/>
    </nz-input-group>
    <ng-template #suffixIconButton>
      <button nz-button nzType="primary" nzSearch (click)="onClickSearch()"><i nz-icon nzType="search"></i></button>
    </ng-template>
    <!--    search bar end-->

    <!--    refresh button start-->
    <button nz-button nzType="primary" (click)="refreshData()" class="table-top-opt" nz-popover [nzContent]="'刷新'">
      <i nz-icon nzType="reload"></i>
    </button>
    <!--    refresh button end-->
  </div>

</div>


<!--list start-->
<nz-table
  nzShowSizeChanger
  [nzData]="listOfData"
  [nzFrontPagination]="false"
  [nzLoading]="loading"
  [nzTotal]="total"
  [nzPageSize]="pageSize"
  [(nzPageIndex)]="pageIndex"
  (nzQueryParams)="onQueryParamsChange($event)"
  >
  <thead>
  <tr>
#foreach($column in $tableInfo.otherColumn)
    <th>$!{column.comment}</th>
#end
    <th>操作</th>
  </tr>
  </thead>
  <tbody>
  <tr *ngFor="let data of listOfData">
#foreach($column in $tableInfo.otherColumn)
    <td>{{ data.$!{column.name} }}</td>
#end
    <td>
      <a (click)="createEditModal(data)">更新</a>
      <nz-divider nzType="vertical"></nz-divider>
      <a (click)="createDeleteModal(data)">删除</a>
    </td>
  </tr>
  </tbody>
</nz-table>
<!--list end-->

```

### list.component.ts

```typescript
##引入宏定义
$!angularDefine

##使用宏定义设置回调（保存位置与文件后缀）
#save("/$!tool.firstLowerCase($!{tableInfo.name})/$!tool.firstLowerCase($!{tableInfo.name})-list", "-list.component.ts")

import {Component, OnInit, ViewContainerRef} from '@angular/core';
import {$!{tableInfo.name}} from '../../../domain/$!tool.append($!tool.firstLowerCase($!{tableInfo.name}),".model")';
import {$!{tableInfo.name}Service} from '../$!tool.append($!tool.firstLowerCase($!{tableInfo.name}),".service")';
import {$!{tableInfo.name}CreateComponent} from '../$!tool.firstLowerCase($!{tableInfo.name})-create/$!tool.firstLowerCase($!{tableInfo.name})-create.component';
import {$!{tableInfo.name}UpdateComponent} from '../$!tool.firstLowerCase($!{tableInfo.name})-update/$!tool.firstLowerCase($!{tableInfo.name})-update.component';
import {NzMessageService} from 'ng-zorro-antd';
import {FormBuilder} from '@angular/forms';
import {NzModalService} from 'ng-zorro-antd/modal';
import {NzTableQueryParams} from 'ng-zorro-antd/table';

@Component({
  selector: 'app-$!tool.firstLowerCase($!{tableInfo.name})-list',
  templateUrl: './$!tool.firstLowerCase($!{tableInfo.name})-list.component.html',
  styleUrls: ['./$!tool.firstLowerCase($!{tableInfo.name})-list.component.css']
})
export class $!{tableInfo.name}ListComponent implements OnInit {

  // 搜索框中的查询条件
  queryParamValue = '';

  // 表单数据集合
  listOfData: $!{tableInfo.name}[];
  // 表单数据的总数
  total = 1;
  // 表单分页的大小
  pageSize = 10;
  // 表单分页的页数
  pageIndex = 1;
  // 表单是否在加载中
  loading = true;

  constructor(private fb: FormBuilder,
              private service: $!{tableInfo.name}Service,
              private modal: NzModalService,
              private message: NzMessageService,
              private viewContainerRef: ViewContainerRef) {
  }

  ngOnInit(): void {
    this.refreshData();
  }


  /**
   * 创建添加对话框
   */
  createAddModal(): void {

    const modal = this.modal.create({
      nzTitle: '添加$!{tableInfo.comment}',
      nzContent: $!{tableInfo.name}CreateComponent,
      nzViewContainerRef: this.viewContainerRef,
      nzComponentParams: {
        data: '',
      },
      nzOnOk: (componentInstance: $!{tableInfo.name}CreateComponent) => {
        const isValid: boolean = componentInstance.isValidForm();
        if (isValid) {
          const result: $!{tableInfo.name} = componentInstance.getFormData();
          this.create$!{tableInfo.name}(result);
          return result;
        }
        return false;
      }

    });
    modal.afterOpen.subscribe(() => console.log('[afterOpen] emitted!'));
    // Return a result when closed
    modal.afterClose.subscribe(result => {
      console.log('[afterClose] The result is:', result);
    });

  }

  /**
   * 创建编辑对话框
   */
  createEditModal($!tool.firstLowerCase($!{tableInfo.name}): any): void {

    const modal = this.modal.create({
      nzTitle: '编辑$!{tableInfo.comment}',
      nzContent: $!{tableInfo.name}UpdateComponent,
      nzViewContainerRef: this.viewContainerRef,
      nzComponentParams: {
        data: $!tool.firstLowerCase($!{tableInfo.name}),
      },
      nzOnOk: (componentInstance: $!{tableInfo.name}UpdateComponent) => {
        const isValid: boolean = componentInstance.isValidForm();
        if (isValid) {
          const result: $!{tableInfo.name} = componentInstance.getFormData();
          this.update$!{tableInfo.name}(result.id, result);
          return result;
        }
        return false;
      }
    });
    modal.afterOpen.subscribe(() => console.log('[afterOpen] emitted!'));
    // Return a result when closed
    modal.afterClose.subscribe(result => console.log('[afterClose] The result is:', result));
  }

  /**
   * 创建删除对话框
   * @param $!tool.firstLowerCase($!{tableInfo.name}) 待删除的$!{tableInfo.comment}
   */
  createDeleteModal($!tool.firstLowerCase($!{tableInfo.name}): $!{tableInfo.name}): void {

    const modal = this.modal.confirm({
      nzTitle: '删除$!{tableInfo.comment}',
      nzContent: '确定删除$!{tableInfo.comment}" ' + $!tool.firstLowerCase($!{tableInfo.name}).title + ' "吗？',
      nzOnOk: () => {
        this.delete$!{tableInfo.name}($!tool.append($!tool.firstLowerCase($!{tableInfo.name}),".id"));
      }
    });
    modal.afterOpen.subscribe(() => console.log('[afterOpen] emitted!'));
    // Return a result when closed
    modal.afterClose.subscribe(result => console.log('[afterClose] The result is:', result));
  }


  /**
   * 调用后台api创建$!{tableInfo.comment}
   * @param $!tool.firstLowerCase($!{tableInfo.name}) $!{tableInfo.comment}
   */
  create$!{tableInfo.name}($!tool.firstLowerCase($!{tableInfo.name}): $!{tableInfo.name}): void {
    const messageId = this.message.loading('正在创建中...', {nzDuration: 0}).messageId;
    this.service.create$!{tableInfo.name}($!tool.firstLowerCase($!{tableInfo.name})).subscribe(
      (data) => {
        console.log(data);
        this.refreshData();
        this.message.success('创建成功！');
        this.message.remove(messageId);
      },
      (error) => {
        console.error(error);
        this.message.error('创建失败！');
        this.message.remove(messageId);
      });
  }

  /**
   * 调用后台api获取$!{tableInfo.comment}列表（根据过滤条件）
   *
   * @return $!{tableInfo.comment}列表
   */
  query$!{tableInfo.name}s(
    pageIndex: number,
    pageSize: number,
    sortField: string | null,
    sortOrder: string | null,
    filter: Array<{ key: string; value: string[] }>
  ): void {
    // 使用表单loading机制代替消息提示
    // const messageId = this.message.loading('正在获取中...', {nzDuration: 0}).messageId;
    this.loading = true;
    this.service.query$!{tableInfo.name}s(pageIndex, pageSize, sortField, sortOrder, filter).subscribe(
      (data) => {
        this.loading = false;
        // this.message.remove(messageId);
        // this.message.success('获取成功！');
        this.total = data.totalCount;
        this.listOfData = data.data;
      },
      (error) => {
        console.log('error: ' + error);
        this.loading = false;
        this.message.error('获取失败！');
        // this.message.remove(messageId);
      }
    );
  }

  /**
   * 调用后台api删除$!{tableInfo.comment}
   * @param id $!{tableInfo.comment}id
   */
  delete$!{tableInfo.name}(id: string): void {
    const messageId = this.message.loading('正在删除中...', {nzDuration: 0}).messageId;
    this.service.delete$!{tableInfo.name}(id).subscribe(
      (data) => {
        console.log('next: ' + data);
        this.message.remove(messageId);
        this.message.success('删除成功！');
        this.refreshData();
      },
      (error) => {
        console.log('error: ' + error);
        this.message.error('删除失败！');
        this.message.remove(messageId);
      }
    );
  }

  /**
   * 调用后台api更新$!{tableInfo.comment}
   * @param id $!{tableInfo.comment}id
   * @param updateData 更新数据
   */
  update$!{tableInfo.name}(id: string, updateData: $!{tableInfo.name}): void {
    const messageId = this.message.loading('正在更新中...', {nzDuration: 0}).messageId;
    this.service.update$!{tableInfo.name}(id, updateData).subscribe(
      (data) => {
        console.log('next: ' + data);
        this.message.remove(messageId);
        this.message.success('更新成功！');
        this.refreshData();
      },
      (error) => {
        console.log('error: ' + error);
        this.message.error('更新失败！');
        this.message.remove(messageId);
      }
    );
  }

  /**
   * 刷新数据
   */
  refreshData(): void {
    // 重置搜索框
    this.queryParamValue = '';
    // 重置分页
    this.pageIndex = 1;

    this.query$!{tableInfo.name}s(this.pageIndex, this.pageSize, null, null, []);
  }

  /**
   * 监听搜索框键盘回车事件
   * @param event 事件
   */
  onKey(event: any): void {
    if (event.code === 'Enter') {
      this.onClickSearch();
    }
  }

  /**
   * 搜索按钮点击事件
   */
  onClickSearch(): void {
    // 一般字符首尾处空格都是由于用户误输入，直接忽略字符首尾处多余的空格
    this.queryParamValue = this.queryParamValue.trim();
    // 重置分页
    this.pageIndex = 1;
    const sortField = null;
    const sortOrder = null;
    const filter: Array<{ key: string; value: string[] }> = new Array<{ key: string; value: string[] }>();
    filter.push({key: 'title', value: [this.queryParamValue]});
    this.query$!{tableInfo.name}s(this.pageIndex, this.pageSize, sortField, sortOrder, filter);
  }

  /**
   * 表格参数变更事件
   * @param params 表格参数
   */
  onQueryParamsChange(params: NzTableQueryParams): void {
    // console.log(params);
    const {pageSize, pageIndex, sort, filter} = params;
    const currentSort = sort.find(item => item.value !== null);
    const sortField = (currentSort && currentSort.key) || null;
    const sortOrder = (currentSort && currentSort.value) || null;
    // 获取搜索框中的数据，添加至过滤条件中
    filter.push({key: 'title', value: [this.queryParamValue]});
    this.query$!{tableInfo.name}s(pageIndex, pageSize, sortField, sortOrder, filter);
  }
}

```

### service.ts

```typescript
##引入宏定义
$!angularDefine

##使用宏定义设置回调（保存位置与文件后缀）
#save("/$!tool.firstLowerCase($!{tableInfo.name})", ".service.ts")

import {Injectable} from '@angular/core';
import {Observable} from 'rxjs';
import {HttpClient, HttpHeaders, HttpParams} from '@angular/common/http';
import {$!{tableInfo.name}} from '../../domain/$!tool.append($!tool.firstLowerCase($!{tableInfo.name}),".model")';
import {$!{tableInfo.name}Page} from '../../domain/$!tool.append($!tool.firstLowerCase($!{tableInfo.name}),".page")';

const httpOptions = {
  headers: new HttpHeaders({'Content-Type': 'application/json'})
};

@Injectable({
  providedIn: 'root'
})
export class $!{tableInfo.name}Service {

  constructor(private http: HttpClient) {
  }


  /**
   * 创建$!{tableInfo.comment}
   *
   * @param $!tool.firstLowerCase($!{tableInfo.name}) $!{tableInfo.comment}
   * @return $!{tableInfo.comment}
   */
  create$!{tableInfo.name}($!tool.firstLowerCase($!{tableInfo.name}): $!{tableInfo.name}): Observable<any> {
    const url = '/mo/v1/$!tool.firstLowerCase($!{tableInfo.name})';
    return this.http.post(url, JSON.stringify($!tool.firstLowerCase($!{tableInfo.name})), httpOptions);
  }

  /**
   * 删除$!{tableInfo.comment}
   *
   * @param id $!{tableInfo.comment}的id
   */
  delete$!{tableInfo.name}(id: string): Observable<any> {
    const url = '/mo/v1/$!tool.firstLowerCase($!{tableInfo.name})/' + id;
    return this.http.delete(url);
  }

  /**
   * 获取$!{tableInfo.comment}列表
   *
   * @return $!{tableInfo.comment}列表
   */
  list$!{tableInfo.name}s(): Observable<$!{tableInfo.name}[]> {
    const url = '/mo/v1/$!tool.firstLowerCase($!{tableInfo.name})';
    return this.http.get<$!{tableInfo.name}[]>(url);
  }

  /**
   * 获取$!{tableInfo.comment}列表（根据过滤条件）
   *
   * @return $!{tableInfo.comment}列表
   */
  query$!{tableInfo.name}s(
    pageIndex: number,
    pageSize: number,
    sortField: string | null,
    sortOrder: string | null,
    filters: Array<{ key: string; value: string[] }>
  ): Observable<$!{tableInfo.name}Page> {
    // 由于表格分页组件默认从1开始，为了兼容，人为减1
    pageIndex = pageIndex > 0 ? pageIndex - 1 : 0;
    let params = new HttpParams()
      .append('page', `${pageIndex}`)
      .append('results', `${pageSize}`)
      .append('sortField', `${sortField}`)
      .append('sortOrder', `${sortOrder}`);
    filters.forEach(filter => {
      filter.value.forEach(value => {
        params = params.append(filter.key, value);
      });
    });
    const url = '/mo/v1/$!tool.firstLowerCase($!{tableInfo.name})/' + pageIndex + '/' + pageSize;
    return this.http.get<$!{tableInfo.name}Page>(url, {params});
  }

  /**
   * 更新$!{tableInfo.comment}
   *
   * @param id $!{tableInfo.comment}的id
   * @param $!tool.firstLowerCase($!{tableInfo.name}) $!{tableInfo.comment}
   * @return $!{tableInfo.comment}
   */
  update$!{tableInfo.name}(id: string, $!tool.firstLowerCase($!{tableInfo.name}): $!{tableInfo.name}): Observable<$!{tableInfo.name}> {
    const url = '/mo/v1/$!tool.firstLowerCase($!{tableInfo.name})/' + id;
    return this.http.put<$!{tableInfo.name}>(url, JSON.stringify($!tool.firstLowerCase($!{tableInfo.name})), httpOptions);
  }

}
```

### page.ts

```typescript
##引入宏定义
$!angularDefine

##使用宏定义设置回调（保存位置与文件后缀）
#save("/domain", ".page.ts")

import {$!{tableInfo.name}} from './$!tool.append($!tool.firstLowerCase($!{tableInfo.name}),".model")';

##使用宏定义实现类注释信息
#tableComment("分页模型")
export class $!{tableInfo.name}Page {
  /**
   * 总数
   */
  totalCount: number;
  /**
   * 分页第几页
   */
  pageNo: number;
  /**
   * 分页大小
   */
  pageSize: number;
  /**
   * 数据集合
   */
  data: $!{tableInfo.name}[];
}

```