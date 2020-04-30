
; Moving T
; Input variables: n1, x(n)
; m: the term number used to calulate moving mean
; Output variables: t(n)
; t: the t-test value

undef("movingT")
function movingT(x,n1)
begin
    n=dimsizes(x)
    t=new((/n/),"float")
    t=0.0
    n2=n1
    df = n1+n2-2
    n11 = 1.0 / n1
    n22 = 1.0 / n2
    m   = sqrt(n11 + n22)

    do i=n1,n-n1
        x1_mean = dim_avg(x(i-n1:i-1))
        x2_mean = dim_avg(x(i:i+n1-1))
        s1=dim_variance(x(i-n1:i-1))
        s2=dim_variance(x(i:i+n1-1))
        s=sqrt(((n1-1) * s1 + (n2-1) * s2) / (n1 + n2 - 2.0))
        t(i) = (x2_mean - x1_mean) / (s * m)
    end do

    P_t=student_t(t, df)
    P_t=1-P_t
    P_t=where(t.gt.0.0, P_t, -P_t)
    return(P_t)

end

