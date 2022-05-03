import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PostsTabComponent } from './posts-tab.component';

describe('PostsTabComponent', () => {
  let component: PostsTabComponent;
  let fixture: ComponentFixture<PostsTabComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ PostsTabComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(PostsTabComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
