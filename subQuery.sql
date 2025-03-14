USE ssafydb;

--------------------------------------------------
--- 단일행 서브 쿼리
--------------------------------------------------

# 이름이 'SMITH'인 사원과 같은 부서에 근무하는 사원이름, 부서번호 조회
select ename, deptno
from emp
where deptno = (
		select deptno
		from emp
        where ename = 'SMITH'
        );


# 이름이 'SMITH'인 사원보다 나중에 입사한 사원이름, 입사일 조회                      
select ename, hiredate
from emp
where hiredate > (
		select deptno
		from emp
        where ename = 'SMITH'
        );


# 이름이 'SMITH'인 사원의 급여보다 많은 급여를 받는 사원이름, 월급여 조회
select ename, sal
from emp
where sal > (
		select sal
		from emp
        where ename = 'SMITH'
        );


--------------------------------------------------
--- 다중행 서브 쿼리
--------------------------------------------------

# 상사(관리자)인 사원번호, 사원이름 조회
select empno, ename, '관리자'
from emp
where empno in (
	select mgr
    from emp
); #() 안에 관리자 사번 목록


# 상사(관리자)가 아닌 사원번호, 사원이름 조회
select empno, ename, '일반사원'
from emp
where empno not in (
	select mgr
    from emp
    where mgr is not null
);


# SALESMAN의 최저월급여보다 월급여가 많은 사원이름, 월급여 조회

select ename, sal
from emp
where sal > (
	select min(sal)
	from emp
	where job = 'SALESMAN'
     );

-- select ename, sal
-- from emp
-- where sal > any (
-- 	select sal
-- 	from emp
-- 	where job = 'SALESMAN'
--      );  // sal 목록 중 적어도 1개보다 큰



# SALESMAN의 최대월급여보다 월급여가 적은 사원이름, 월급여 조회
select ename, sal
from emp
where sal < any (
	select sal
	from emp
	where job = 'SALESMAN'
     );

        
# SALESMAN의 최대월월급여보다 급여가 많은 사원이름, 월급여 조회



# SALESMAN의 최저월급여보다 급여가 적은 사원이름, 월급여 조회





--------------------------------------------------
--- EXISTS 연산자
--------------------------------------------------

# 상사(관리자)인 사원번호, 사원이름 조회 
select m.empno, m.ename
from emp m
where exists(
		select 1
        from emp e
        where m.empno = e.mgr
		);


# 상사(관리자)가 아닌 사원번호, 사원이름 조회 
select m.empno, m.ename
from emp m
where not exists(
		select 1
        from emp e
        where m.empno = e.mgr
		);



--------------------------------------------------
--- pairwise 서브쿼리
--------------------------------------------------

# 각 부서별로 최대월급여를 받는 사원이름, 월급여, 부서번호 조회
select ename, sal, deptno
from emp
where (ifnull(deptno,''), sal) in (
	select ifnull(deptno,''), max(sal)  #신입 사원 중 부서가 없을 수 있기 때문에 deptno는 null처리 해주자!
    from emp
    group by deptno
);


--------------------------------------------------
--- 스칼라 서브쿼리
--------------------------------------------------

# 사원이름, 월급여, 부서번호, 자신의 부서의 평균 월급여와 전사원 평균 월급여 조회




--------------------------------------------------
--- 인라인 뷰 
--------------------------------------------------

# 각 부서에서 최대급여를 받는 사원번호, 월급여, 사원이름 조회
select deptno, max(sal)
from emp
group by deptno;


select e.ename, e.sal, e.deptno
from (
	select deptno, max(sal) maxsal
	from emp
	group by deptno
    ) d 
join emp e on (e.deptno = d.deptno and e.sal = d.maxsal);



# 부서별, 직무별 사원 수 피봇테이블 조회(서브쿼리(inline-VIEW) 이용버전)



# 부서별, 직무별 월급여 평균 피봇테이블 조회(서브쿼리(inline-VIEW) 이용버전)



# 부서별, 직무별 사원수 조회 피봇테이블 with 총계 조회 (서브쿼리(inline-VIEW) 이용버전)




------------------------------------------------------------------ 
-- 집합 연산자
------------------------------------------------------------------ 

# 주문을 했거나 이벤트를 신청한 고객번호와 주문/이벤트 타입 조회



# 주문을 했거나 이벤트를 신청한 고객번호 중복 없이 조회



# 주문도 하고 이벤트도 신청한 고객번호 조회



# 주문은 했으나 이벤트는 한번도 신청하지 않은 고객번호 조회



# 이벤트는 신청했으나 주문은 한번도 하지 않은 고객번호 조회


