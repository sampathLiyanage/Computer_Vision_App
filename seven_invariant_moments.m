function [M]=seven_invariant_moments(A)

% First Moment
n20=getCentMoment(2,0,A);
n02=getCentMoment(0,2,A);
M1=n20+n02;

% Second Moment
n20=getCentMoment(2,0,A);
n02=getCentMoment(0,2,A);
n11=getCentMoment(1,1,A);
M2=(n20-n02)^2+4*n11^2;

% Third Moment
n30=getCentMoment(3,0,A);
n12=getCentMoment(1,2,A);
n21=getCentMoment(2,1,A);
n03=getCentMoment(0,3,A);
M3=(n30-3*n12)^2+(3*n21-n03)^2;

% Fourth Moment
n30=getCentMoment(3,0,A);
n12=getCentMoment(1,2,A);
n21=getCentMoment(2,1,A);
n03=getCentMoment(0,3,A);
M4=(n30+n12)^2+(n21+n03)^2;

% Fifth Moment
n30=getCentMoment(3,0,A);
n12=getCentMoment(1,2,A);
n21=getCentMoment(2,1,A);
n03=getCentMoment(0,3,A);
M5=(n30-3*n21)*(n30+n12)*[(n30+n12)^2-3*(n21+n03)^2]+(3*n21-n03)*(n21+n03)*[3*(n30+n12)^2-(n21+n03)^2];

% Sixth Moment
n20=getCentMoment(2,0,A);
n02=getCentMoment(0,2,A);
n30=getCentMoment(3,0,A);
n12=getCentMoment(1,2,A);
n21=getCentMoment(2,1,A);
n03=getCentMoment(0,3,A);
n11=getCentMoment(1,1,A);
M6=(n20-n02)*[(n30+n12)^2-(n21+n03)^2]+4*n11*(n30+n12)*(n21+n03);

% Seventh Moment
n30=getCentMoment(3,0,A);
n12=getCentMoment(1,2,A);
n21=getCentMoment(2,1,A);
n03=getCentMoment(0,3,A);
M7=(3*n21-n03)*(n30+n12)*[(n30+n12)^2-3*(n21+n03)^2]-(n30+3*n12)*(n21+n03)*[3*(n30+n12)^2-(n21+n03)^2];

M=[M1    M2     M3    M4     M5    M6    M7]';

function n_pq=getCentMoment(p,q,A)

 [m      n]=size(A);
 moo=sum(sum(A));
 
  m1o=0;
  mo1=0;
    for x=0:m-1
        for y=0:n-1
            m1o=m1o+(x)*A(x+1,y+1);
            mo1=mo1+(y)*A(x+1,y+1);
        end 
    end
  xx=m1o/moo;
  yy=mo1/moo;
    
    
  mu_oo=moo;
    
    mu_pq=0;
    for ii=0:m-1
        x=ii-xx;
        for jj=0:n-1
            y=jj-yy;
            mu_pq=mu_pq+(x)^p*(y)^q*A(ii+1,jj+1);
        end 
    end
    
    gamma=0.5*(p+q)+1;
    n_pq=mu_pq/moo^(gamma);
   