/**
 * Created with IntelliJ IDEA.
 * User: Ivan
 * Date: 14.07.13
 * Time: 17:06
 * To change this template use File | Settings | File Templates.
 */
import java.lang.Math;

public class HUGO {

    public int T,weightForm,signed;
    public double gamma,sigma,shift,probability;
    public double [][]weight2d;




    public HUGO(int T)
    {
        this(T,4,10);
    }
    public HUGO()
    {
        this(3);
    }
    public HUGO(int T,double gamma,double sigma)
    {    this(T,gamma,sigma,1);
    }

    public HUGO(int T,double gamma,double sigma,int weightForm)
    {
        this.T=T;
        this.gamma=gamma;
        this.sigma=sigma;
        this.weightForm=weightForm;
        this.shift=2;
    }
    public HUGO(int T,double gamma,double sigma,int weightForm,double [][]weighMatrix)
    {
        this.T=T;
        this.gamma=gamma;
        this.sigma=sigma;
        this.weightForm=weightForm;
        this.shift=2;
        this.signed=0;



        if(weightForm==4 ||weightForm==5)
        {
            this.weight2d=weighMatrix;
            if(weighMatrix.length!=2*T+1)
                try {
                    throw new Exception("Wrong weightMatrix size must be 2*T+1"  );
                } catch (Exception e) {
                    e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
                    return;
                }
        }
    }

    public HUGO(int T,double gamma,double sigma,int weightForm,double [][]weighMatrix,int signed)
    {
        this.T=T;
        this.gamma=gamma;
        this.sigma=sigma;
        this.weightForm=weightForm;
        this.shift=2;
        this.signed=signed;



        if(weightForm==4||weightForm==5)
        {
            this.weight2d=weighMatrix;
            if(weighMatrix.length!=2*T+1)
                try {
                    throw new Exception("Wrong weightMatrix size must be 2*T+1"  );
                } catch (Exception e) {
                    e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
                    return;
                }
        }
    }


    public HUGO(int T,double gamma,double sigma,int weightForm,double [][]weighMatrix,int signed,double probability)
    {
        this.T=T;
        this.gamma=gamma;
        this.sigma=sigma;
        this.weightForm=weightForm;
        this.shift=2;
        this.signed=signed;
        this.probability=probability;



        if(weightForm==4||weightForm==5)
        {
            this.weight2d=weighMatrix;
            if(weighMatrix.length!=2*T+1)
                try {
                    throw new Exception("Wrong weightMatrix size must be 2*T+1"  );
                } catch (Exception e) {
                    e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
                    return;
                }
        }
    }


    public int[][][]   getD(int [][] I)
    {
        int i,j,k;
        /*UNTITLED2 Summary of this function goes here
               Detailed explanation goes here
            D(0) - from left to right
            D(1) - from right to left
            D(2) - from top to bottom
            D(3) - from bottom to top
            D(4) - from upper left to bottom right
            D(5) - from bottom right to upper left
            D(6) - from upper right to bottom left
            D(7) - from bottom left to upper right
            */

        int n= I.length;
        int m = I[0].length;

        int[][][] D = new int[n][m][8];

        for (i =0;i<n;i++)
            for (j =0;j<m;j++)
                for (k =0;k<8;k++)
                    D[i][j][k]=32768;


        //D(0) - from left to right
        for (i=0;i<n;i++)
            for (j=0;j<m-1;j++)
                D[i][j][0]= I[i][j]-I[i][j+1];

        //D(1) - from right to left
        for (i=0;i<n;i++)
            for (j=1;j<m;j++)
                D[i][j][1]= I[i][j]-I[i][j-1];

        //D(2) - from top to bottom
        for (i=0;i<n-1;i++)
            for (j=0;j<m;j++)
                D[i][j][2]= I[i][j]-I[i+1][j];

        //D(3) - from bottom to top
        for (i=1;i<n;i++)
            for (j=0;j<m;j++)
                D[i][j][3]= I[i][j]-I[i-1][j];

        //D(4) - from upper left to bottom right
        for (i=0;i<n-1;i++)
            for (j=0;j<m-1;j++)
                D[i][j][4]= I[i][j]-I[i+1][j+1];

        //D(5) - from bottom right to upper left
        for (i=1;i<n;i++)
            for (j=1;j<m;j++)
                D[i][j][5]= I[i][j]-I[i-1][j-1];

        //D(6) - from upper right to bottom left
        for (i=0;i<n-1;i++)
            for (j=1;j<m;j++)
                D[i][j][6]= I[i][j]-I[i+1][j-1];

        //D(7) - from bottom left to upper right
        for (i=1;i<n;i++)
            for (j=0;j<m-1;j++)
                D[i][j][7]= I[i][j]-I[i-1][j+1];

        return D;

    }

    public double [][][] getC2(int [][][] D)
     {
         double [][][] C = new double[2*T+1][2*T+1][8];
         int i,j,k,n,m;


         n = D.length;
         m =D[0].length;



         for(i=0;i<2*T+1;i++)
             for(j=0;j<2*T+1;j++)
                 for(k=0;k<8;k++)
                     C[i][j][k]=0;

         k=0;
         for(i=0;i<n;i++)
             for(j=0;j<m-1;j++)
                 if(Math.abs(D[i][j][k])<=T && Math.abs(D[i][j+1][k])<=T)
                     C[D[i][j][k]+T][D[i][j+1][k]+T][k]=C[D[i][j][k]+T][D[i][j+1][k]+T][k]+1;

         k=1;
         for (i=0;i<n;i++)
             for (j=2;j<m;j++)
                 if(Math.abs(D[i][j][k])<=T && Math.abs(D[i][j-1][k])<=T)
                     C[D[i][j][k]+T][D[i][j-1][k]+T][k]+=1;

         k=2;
         for (i=0;i<n-1;i++)
             for (j=0;j<m;j++)
                 if(Math.abs(D[i][j][k])<=T && Math.abs(D[i+1][j][k])<=T)
                     C[D[i][j][k]+T][D[i+1][j][k]+T][k]+=1;

         k=3;
         for (i=1;i<n;i++)
             for (j=0;j<m;j++)
                 if(Math.abs(D[i][j][k])<=T && Math.abs(D[i-1][j][k])<=T)
                     C[D[i][j][k]+T][D[i-1][j][k]+T][k]+=1;

         k=4;
         for (i=0;i<n-1;i++)
             for (j=0;j<m-1;j++)
                 if(Math.abs(D[i][j][k])<=T && Math.abs(D[i+1][j+1][k])<=T)
                     C[D[i][j][k]+T][D[i+1][j+1][k]+T][k]+=1;

         k=5;
         for (i=1;i<n;i++)
             for (j=1;j<m;j++)
                 if(Math.abs(D[i][j][k])<=T && Math.abs(D[i-1][j-1][k])<=T)
                     C[D[i][j][k]+T][D[i-1][j-1][k]+T][k]+=1;

         k=6;
         for (i=0;i<n-1;i++)
             for (j=1;j<m;j++)
                 if(Math.abs(D[i][j][k])<=T && Math.abs(D[i+1][j-1][k])<=T)
                     C[D[i][j][k]+T][D[i+1][j-1][k]+T][k]+=1;
         k=7;
         for (i=1;i<n;i++)
             for (j=0;j<m-1;j++)
                 if(Math.abs(D[i][j][k])<=T && Math.abs(D[i-1][j+1][k])<=T)
                     C[D[i][j][k]+T][D[i-1][j+1][k]+T][k]+=1;

         for(i=0;i<2*T+1;i++)
             for(j=0;j<2*T+1;j++)
                 for(k=0;k<8;k++)
                     C[i][j][k]/=(n*m);

        return C;
     }

    public double [][][][] getC3(int [][][] D)
    {
        double [][][][] C = new double[2*T+1][2*T+1][2*T+1][8];
        int i,j,l,k,n,m;


        n = D.length;
        m =D[0].length;

        for(i=0;i<2*T+1;i++)
            for(j=0;j<2*T+1;j++)
                for(l=0;l<2*T+1;l++)
                    for(k=0;k<8;k++)
                        C[i][j][l][k]=0;

        k=0;
        for(i=0;i<n;i++)
            for(j=0;j<m-2;j++)
                if(Math.abs(D[i][j][k])<=T && Math.abs(D[i][j+1][k])<=T && Math.abs(D[i][j+2][k])<=T)
                    C[D[i][j][k]+T][D[i][j+1][k]+T][D[i][j+2][k]+T][k]+=1;

        k=1;
        for(i=0;i<n;i++)
            for(j=2;j<m;j++)
                if(Math.abs(D[i][j][k])<=T && Math.abs(D[i][j-1][k])<=T && Math.abs(D[i][j-2][k])<=T)
                    C[D[i][j][k]+T][D[i][j-1][k]+T][D[i][j-2][k]+T][k]+=1;

        k=2;
        for(i=0;i<n-2;i++)
            for(j=0;j<m;j++)
                if(Math.abs(D[i][j][k])<=T && Math.abs(D[i+1][j][k])<=T && Math.abs(D[i+2][j][k])<=T)
                    C[D[i][j][k]+T][D[i+1][j][k]+T][D[i+2][j][k]+T][k]+=1;

        k=3;
        for(i=2;i<n;i++)
            for(j=0;j<m;j++)
                if(Math.abs(D[i][j][k])<=T && Math.abs(D[i-1][j][k])<=T && Math.abs(D[i-2][j][k])<=T)
                    C[D[i][j][k]+T][D[i-1][j][k]+T][D[i-2][j][k]+T][k]+=1;

        k=4;
        for(i=0;i<n-2;i++)
            for(j=0;j<m-2;j++)
                if(Math.abs(D[i][j][k])<=T && Math.abs(D[i+1][j+1][k])<=T && Math.abs(D[i+2][j+2][k])<=T)
                    C[D[i][j][k]+T][D[i+1][j+1][k]+T][D[i+2][j+2][k]+T][k]+=1;

        k=5;
        for(i=2;i<n;i++)
            for(j=2;j<m;j++)
                if(Math.abs(D[i][j][k])<=T && Math.abs(D[i-1][j-1][k])<=T && Math.abs(D[i-2][j-2][k])<=T)
                    C[D[i][j][k]+T][D[i-1][j-1][k]+T][D[i-2][j-2][k]+T][k]+=1;

        k=6;
        for(i=0;i<n-2;i++)
            for(j=2;j<m;j++)
                if(Math.abs(D[i][j][k])<=T && Math.abs(D[i+1][j-1][k])<=T && Math.abs(D[i+2][j-2][k])<=T)
                    C[D[i][j][k]+T][D[i+1][j-1][k]+T][D[i+2][j-2][k]+T][k]+=1;

        k=7;
        for(i=2;i<n;i++)
            for(j=0;j<m-2;j++)
                if(Math.abs(D[i][j][k])<=T && Math.abs(D[i-1][j+1][k])<=T && Math.abs(D[i-2][j+2][k])<=T)
                    C[D[i][j][k]+T][D[i-1][j+1][k]+T][D[i-2][j+2][k]+T][k]+=1;

        for(i=0;i<2*T+1;i++)
            for(j=0;j<2*T+1;j++)
                for(l=0;l<2*T+1;l++)
                    for(k=0;k<8;k++)
                        C[i][j][l][k]/=(n*m);

        return C;
    }

    public double [][] getC2Full(int [][]I)
    {
        int i,j;
        int [][][]D;
        double [][][] C;
        double [][] C2=new double[2*T+1][2*T+1];


        D=getD(I);
        C=getC2(D);

         for (i=0;i<2*T+1;i++)
             for(j=0;j<2*T+1;j++)
                 C2[i][j]=(C[i][j][0]+C[i][j][1]+C[i][j][2]+C[i][j][3]+C[i][j][4]+C[i][j][5]+C[i][j][6]+C[i][j][7])/8;



        return (C2);
    }

    public int[][][]   recalculateD(int [][] I,int [][][] oldD,int iChanged,int jChanged)
    {
        int i,j,k;
        /*UNTITLED2 Summary of this function goes here
               Detailed explanation goes here
            D(0) - from left to right
            D(1) - from right to left
            D(2) - from top to bottom
            D(3) - from bottom to top
            D(4) - from upper left to bottom right
            D(5) - from bottom right to upper left
            D(6) - from upper right to bottom left
            D(7) - from bottom left to upper right
            */

        int n= I.length;
        int m = I[0].length;


        int[][][] D = ArrayManipulator.copyByVal(oldD);




//D(0) - from left to right
        i=iChanged;
        for(j=jChanged-1;j<=jChanged;j++)
        {
            if(i>=n || i<0||j<0||j>=m-1)
                continue;
            D[i][j][0]=I[i][j]-I[i][j+1];
        }
//D(1) - from right to left
        i=iChanged;
        for(j=jChanged;j<=jChanged+1;j++)
        {
            if(j<1||i<0||j>=m||i>=n)
                continue;
            D[i][j][1]=I[i][j]-I[i][j-1];
        }

//D(2) - from top to bottom
        j=jChanged;
        for (i=iChanged-1;i<=iChanged;i++)
        {

            if(i>=n-1||i<0||j<0||j>=m||i>n) continue;
            D[i][j][2]= I[i][j]-I[i+1][j];
        }

//D(3) - from bottom to top
        j=jChanged;
        for (i=iChanged;i<=iChanged+1;i++)
        {
            if(i<1||j<0||j>=m||i>=n) continue;
            D[i][j][3]= I[i][j]-I[i-1][j];

        }

//D(4) - from upper left to bottom right
        i=iChanged-1; j=jChanged-1;
        if(!(i>=n-1||j>=m-1||i<0||j<0||j>=m||i>=n))
            D[i][j][4]= I[i][j]-I[i+1][j+1];
        i=iChanged; j=jChanged;
        if(!(i>=n-1||j>=m-1||i<0||j<0||j>=m||i>=n))
            D[i][j][4]= I[i][j]-I[i+1][j+1];


//D(5) - from bottom right to upper left
        i=iChanged; j = jChanged;
        if(!(i<1||j<1||i<0||j<0||j>=m||i>=n))
            D[i][j][5]= I[i][j]-I[i-1][j-1];
        i=iChanged+1; j = jChanged+1;
        if(!(i<1||j<1||i<0||j<0||j>=m||i>=n))
            D[i][j][5]= I[i][j]-I[i-1][j-1];


//D(6) - from upper right to bottom left
        i=iChanged; j = jChanged;
        if(!(i>=n-1||j<1||i<0||j<0||j>=m||i>=n))
            D[i][j][6]= I[i][j]-I[i+1][j-1];
        i=iChanged-1; j = jChanged+1;
        if(!(i>=n-1||j<1||i<0||j<0||j>=m||i>=n))
            D[i][j][6]= I[i][j]-I[i+1][j-1];

//D(7) - from bottom left to upper right
        i=iChanged; j = jChanged;
        if(!(i<1||j>=m-1||j<0||j>=m||i>=n))
            D[i][j][7]= I[i][j]-I[i-1][j+1];

        i=iChanged+1; j = jChanged-1;
        if(!(i<1||j>=m-1||j<0||j>=m||i>=n))
            D[i][j][7]= I[i][j]-I[i-1][j+1];


        return D;

    }


    public double [][][] recalculateC2(int [][][] oldD,int [][][] newD,double [][][] oldC,int iChanged,int jChanged)
    {
        int i,j,k;


        int n= newD.length;
        int m = newD[0].length;

        double[][][] C = ArrayManipulator.copyByVal(oldC);
        C=ArrayManipulator.multiplyMatrixByScalar(C,n*m);



        k=0;

        i=iChanged;

        for (j=jChanged-2;j<=jChanged+1;j++)
        {
            if(j >= m-1||j<0||i<0||i>=n ||j>=m) continue;
            if(Math.abs(oldD[i][j][k])<=T && Math.abs(oldD[i][j+1][k])<=T)
                C[oldD[i][j][k]+T][oldD[i][j+1][k]+T][k]-=1;

            if(Math.abs(newD[i][j][k])<=T && Math.abs(newD[i][j+1][k])<=T)
                C[newD[i][j][k]+T][newD[i][j+1][k]+T][k]+=1;
        }




        k=1;
        for (i=1;i<=iChanged;i++)
            for (j=jChanged-1;j<=jChanged+2;j++)
            {
                if(j < 2||j<0||i<0||i>=n ||j>=m) continue;
                if(Math.abs(oldD[i][j][k])<=T && Math.abs(oldD[i][j-1][k])<=T)
                    C[oldD[i][j][k]+T][oldD[i][j-1][k]+T][k]-=1;

                if(Math.abs(newD[i][j][k])<=T && Math.abs(newD[i][j-1][k])<=T)
                    C[newD[i][j][k]+T][newD[i][j-1][k]+T][k]+=1;
            }




        k=2;
        for (i=iChanged-2;i<=iChanged+1;i++)
        {
            j=jChanged;
            if(i>=n-1||j<0||i<0||i>=n ||j>=m) continue;
            if(Math.abs(oldD[i][j][k])<=T && Math.abs(oldD[i+1][j][k])<=T)
                C[oldD[i][j][k]+T][oldD[i+1][j][k]+T][k]-=1;


            if(Math.abs(newD[i][j][k])<=T && Math.abs(newD[i+1][j][k])<=T)
                C[newD[i][j][k]+T][newD[i+1][j][k]+T][k]+=1;
        }



        k=3;

        for (i=iChanged-1;i<=iChanged+2;i++)
        {
            j=jChanged;
            if(i<1||j<0||i<0||i>=n ||j>=m) continue;
            if(Math.abs(oldD[i][j][k])<=T && Math.abs(oldD[i-1][j][k])<=T)
                C[oldD[i][j][k]+T][oldD[i-1][j][k]+T][k]-=1;


            if(Math.abs(newD[i][j][k])<=T && Math.abs(newD[i-1][j][k])<=T)

                C[newD[i][j][k]+T][newD[i-1][j][k]+T][k]+=1;
        }




        k=4;

        for (i=iChanged-2,j=jChanged-2; i<=iChanged+1;i++,j++)
        {

            if(i>=n-1 || j>= m-1||j<0||i<0||i>=n ||j>=m) continue;
            if(Math.abs(oldD[i][j][k])<=T && Math.abs(oldD[i+1][j+1][k])<=T)
                C[oldD[i][j][k]+T][oldD[i+1][j+1][k]+T][k]-=1;

            if(Math.abs(newD[i][j][k])<=T && Math.abs(newD[i+1][j+1][k])<=T)
                C[newD[i][j][k]+T][newD[i+1][j+1][k]+T][k]+=1;

        }


        k=5;

        for (i=iChanged-1,j=jChanged-1; i<=iChanged+2;i++,j++)
        {

            if(i<1 || j<1||j<0||i<0||i>=n ||j>=m) continue;
            if(Math.abs(oldD[i][j][k])<=T && Math.abs(oldD[i-1][j-1][k])<=T)
                C[oldD[i][j][k]+T][oldD[i-1][j-1][k]+T][k]-=1;


            if(Math.abs(newD[i][j][k])<=T && Math.abs(newD[i-1][j-1][k])<=T)
                C[newD[i][j][k]+T][newD[i-1][j-1][k]+T][k]+=1;
        }



        k=6;

        for (i=iChanged+1,j=jChanged-1; i>=iChanged-2;i--,j++)
        {

            if(i>=n-1 || j<1||j<0||i<0||i>=n ||j>=m) continue;
            if(Math.abs(oldD[i][j][k])<=T && Math.abs(oldD[i+1][j-1][k])<=T)
                C[oldD[i][j][k]+T][oldD[i+1][j-1][k]+T][k]-=1;


            if(Math.abs(newD[i][j][k])<=T && Math.abs(newD[i+1][j-1][k])<=T)

                C[newD[i][j][k]+T][newD[i+1][j-1][k]+T][k]+=1;
        }



        k=7;

        for (i=iChanged-1,j=jChanged+1; i<=iChanged+2;i++,j--)
        {
            if(i<1 || j>=m-1||j<0||i<0||i>=n ||j>=m) continue;
            if(Math.abs(oldD[i][j][k])<=T && Math.abs(oldD[i-1][j+1][k])<=T)
                C[oldD[i][j][k]+T][oldD[i-1][j+1][k]+T][k]-=1;


            if(Math.abs(newD[i][j][k])<=T && Math.abs(newD[i-1][j+1][k])<=T)

                C[newD[i][j][k]+T][newD[i-1][j+1][k]+T][k]+=1;

        }







        C=ArrayManipulator.multiplyMatrixByScalar(C,1/((double)(n*m)));
        return C;

    }


    public double [][][][] recalculateC3(int [][][] oldD,int [][][] newD,double [][][][] oldC,int iChanged,int jChanged)
    {
        int i,j,k;


        int n= newD.length;
        int m = newD[0].length;

        double[][][][] C = ArrayManipulator.copyByVal(oldC);
        C=ArrayManipulator.multiplyMatrixByScalar(C,n*m);


        k=0;
        i=iChanged;
        for(j=jChanged-3;j<=jChanged+2;j++)
        {
            if(j >= m-2||j<0||i<0||i>=n ||j>=m) continue;
            if(Math.abs(oldD[i][j][k])<=T && Math.abs(oldD[i][j+1][k])<=T && Math.abs(oldD[i][j+2][k])<=T)
                C[oldD[i][j][k]+T][oldD[i][j+1][k]+T][oldD[i][j+2][k]+T][k]-=1;


            if(Math.abs(newD[i][j][k])<=T && Math.abs(newD[i][j+1][k])<=T && Math.abs(newD[i][j+2][k])<=T)
                C[newD[i][j][k]+T][newD[i][j+1][k]+T][newD[i][j+2][k]+T][k]+=1;
        }

        k=1;
        i=iChanged;
        for(j=jChanged-2;j<=jChanged+3;j++)
        {
            if(j <2||i<0||i>=n ||j>=m) continue;
            if(Math.abs(oldD[i][j][k])<=T && Math.abs(oldD[i][j-1][k])<=T && Math.abs(oldD[i][j-2][k])<=T)
                C[oldD[i][j][k]+T][oldD[i][j-1][k]+T][oldD[i][j-2][k]+T][k]-=1;

            if(Math.abs(newD[i][j][k])<=T && Math.abs(newD[i][j-1][k])<=T && Math.abs(newD[i][j-2][k])<=T)
                C[newD[i][j][k]+T][newD[i][j-1][k]+T][newD[i][j-2][k]+T][k]+=1;
        }

        k=2;
        for(i=iChanged-3;i<=iChanged+2;i++)
        {
            j=jChanged;
            if(i>=n-2||j<0||i<0||i>=n ||j>=m) continue;
            if(Math.abs(oldD[i][j][k])<=T && Math.abs(oldD[i+1][j][k])<=T && Math.abs(oldD[i+2][j][k])<=T)
                C[oldD[i][j][k]+T][oldD[i+1][j][k]+T][oldD[i+2][j][k]+T][k]-=1;


            if(Math.abs(newD[i][j][k])<=T && Math.abs(newD[i+1][j][k])<=T && Math.abs(newD[i+2][j][k])<=T)
                C[newD[i][j][k]+T][newD[i+1][j][k]+T][newD[i+2][j][k]+T][k]+=1;
        }

        k=3;
        for(i=iChanged-2;i<=iChanged+3;i++)
        {
            j=jChanged;
            if(i<2||j<0||i<0||i>=n ||j>=m) continue;
            if(Math.abs(oldD[i][j][k])<=T && Math.abs(oldD[i-1][j][k])<=T && Math.abs(oldD[i-2][j][k])<=T)
                C[oldD[i][j][k]+T][oldD[i-1][j][k]+T][oldD[i-2][j][k]+T][k]-=1;


            if(Math.abs(newD[i][j][k])<=T && Math.abs(newD[i-1][j][k])<=T && Math.abs(newD[i-2][j][k])<=T)
                C[newD[i][j][k]+T][newD[i-1][j][k]+T][newD[i-2][j][k]+T][k]+=1;

        }

        k=4;
        for(i=iChanged-3,j=jChanged-3; i<=iChanged+2;i++,j++)
        {

            if(i>=n-2 || j>= m-2||j<0||i<0||i>=n ||j>=m) continue;
            if(Math.abs(oldD[i][j][k])<=T && Math.abs(oldD[i+1][j+1][k])<=T && Math.abs(oldD[i+2][j+2][k])<=T)
                C[oldD[i][j][k]+T][oldD[i+1][j+1][k]+T][oldD[i+2][j+2][k]+T][k]-=1;

            if(Math.abs(newD[i][j][k])<=T && Math.abs(newD[i+1][j+1][k])<=T && Math.abs(newD[i+2][j+2][k])<=T)
                C[newD[i][j][k]+T][newD[i+1][j+1][k]+T][newD[i+2][j+2][k]+T][k]+=1;
        }

        k=5;

        for(i=iChanged-2,j=jChanged-2; i<=iChanged+3;i++,j++)
        {
            if(i<2 || j<2||j<0||i<0||i>=n ||j>=m) continue;
            if(Math.abs(oldD[i][j][k])<=T && Math.abs(oldD[i-1][j-1][k])<=T && Math.abs(oldD[i-2][j-2][k])<=T)
                C[oldD[i][j][k]+T][oldD[i-1][j-1][k]+T][oldD[i-2][j-2][k]+T][k]-=1;


            if(Math.abs(newD[i][j][k])<=T && Math.abs(newD[i-1][j-1][k])<=T && Math.abs(newD[i-2][j-2][k])<=T)
                C[newD[i][j][k]+T][newD[i-1][j-1][k]+T][newD[i-2][j-2][k]+T][k]+=1;
        }

        k=6;
        for(i=iChanged+2,j=jChanged-2; i>=iChanged-3;i--,j++)
        {
            if(i>=n-2 || j<2||j<0||i<0||i>=n ||j>=m) continue;
            if(Math.abs(oldD[i][j][k])<=T && Math.abs(oldD[i+1][j-1][k])<=T && Math.abs(oldD[i+2][j-2][k])<=T)
                C[oldD[i][j][k]+T][oldD[i+1][j-1][k]+T][oldD[i+2][j-2][k]+T][k]-=1;


            if(Math.abs(newD[i][j][k])<=T && Math.abs(newD[i+1][j-1][k])<=T && Math.abs(newD[i+2][j-2][k])<=T)
                C[newD[i][j][k]+T][newD[i+1][j-1][k]+T][newD[i+2][j-2][k]+T][k]+=1;
        }

        k=7;
        for(i=iChanged-2,j=jChanged+2; i<=iChanged+3;i++,j--)
        {
            if(i<2 || j>=m-2||j<0||i<0||i>=n ||j>=m) continue;
            if(Math.abs(oldD[i][j][k])<=T && Math.abs(oldD[i-1][j+1][k])<=T && Math.abs(oldD[i-2][j+2][k])<=T)
                C[oldD[i][j][k]+T][oldD[i-1][j+1][k]+T][oldD[i-2][j+2][k]+T][k]-=1;

            if(Math.abs(newD[i][j][k])<=T && Math.abs(newD[i-1][j+1][k])<=T && Math.abs(newD[i-2][j+2][k])<=T)
                C[newD[i][j][k]+T][newD[i-1][j+1][k]+T][newD[i-2][j+2][k]+T][k]+=1;
        }

        C=ArrayManipulator.multiplyMatrixByScalar(C,1/((double)(n*m)));
        return C;

    }

    public double [][][] getCosts(int [][]I,int dim)
    {
        int m=I.length;
        int n=I[0].length;
        int i,j;

        double [][][] Costs=new double[m][n][2];

        for(i=0;i<m;i++)
            for(j=0;j<n;j++)
            {
                Costs[i][j][0]=0;
                Costs[i][j][1]=0;
            }

        //0 -1
        //1 +1

        int [][] I1=  ArrayManipulator.copyByVal(I);

        for(i = 0; i<m;i++)
            for(j=0;j<n;j++)
            {
                I1[i][j]=I[i][j]-1;
                Costs[i][j][0]=getDistortion(I,I1,dim);

                I1[i][j]=I[i][j]+1;
                Costs[i][j][1]=getDistortion(I,I1,dim);

                I1[i][j]=I[i][j];
            }




        return Costs;

    }



    public double [][][] getCostsSmart2(int [][]I)
    {
        int m=I.length;
        int n=I[0].length;
        int i,j;
        int [][][]D;
        double [][][] C;

        double [][][] Costs=new double[m][n][2];

        //0 -1
        //1 +1

        int [][] I1=  ArrayManipulator.copyByVal(I);
        D=getD(I);
        C=getC2(D);


        for(i = 0; i<m;i++)
            for(j=0;j<n;j++)
            {
                if(I[i][j]!=0)
                {
                I1[i][j]=I[i][j]-1;
                Costs[i][j][0]=getDistortion2Smart(I,I1,D,D,C,C,i,j);
                }
                else Costs[i][j][0]=Double.POSITIVE_INFINITY;
                if(I[i][j]!=255)
                {
                I1[i][j]=I[i][j]+1;
                Costs[i][j][1]=getDistortion2Smart(I,I1,D,D,C,C,i,j);
                }
                else Costs[i][j][1]=Double.POSITIVE_INFINITY;

                I1[i][j]=I[i][j];
            }

        return Costs;

    }


    public double [][][] getCostsSmart3(int [][]I)
    {
        int m=I.length;
        int n=I[0].length;
        int i,j;
        int [][][]D;
        double [][][][] C;

        double [][][] Costs=new double[m][n][2];

        //0 -1
        //1 +1

        int [][] I1=  ArrayManipulator.copyByVal(I);
        D=getD(I);
        C=getC3(D);


        for(i = 0; i<m;i++)
            for(j=0;j<n;j++)
            {
                if(I[i][j]!=0)
                {
                I1[i][j]=I[i][j]-1;
                Costs[i][j][0]=getDistortion3Smart(I,I1,D,D,C,C,i,j);
                }
                else Costs[i][j][0]=Double.POSITIVE_INFINITY;

                if(I[i][j]!=255)
                {
                I1[i][j]=I[i][j]+1;
                Costs[i][j][1]=getDistortion3Smart(I,I1,D,D,C,C,i,j);
                }
                else Costs[i][j][1]=Double.POSITIVE_INFINITY;

                I1[i][j]=I[i][j];
            }

        return Costs;

    }

    public double [][][] getCostsSmart(int [][]I,int dim)
    {
        double [][][]Costs;

        if(dim==2) {
            Costs=getCostsSmart2(I);
            return Costs;
        }
        else if(dim==3)  {
            Costs=getCostsSmart3(I);
            return Costs;
        }

        return null;

    }


    public double getDistortion3(int [][]X,int [][]Y)
    {
        double distortion=0,wc,p11,p12,p21,p22;
        double [][][][]    CX = getC3(getD(X));
        double [][][][]    CY = getC3(getD(Y));

        int i,j,z;


        for (i=-T;i<=T;i++)
            for (j=-T;j<=T;j++)
                for (z=-T;z<=T;z++)
                {
                    wc=w(i,j,z);
                    p11=CX[i+T][j+T][z+T][0]+CX[i+T][j+T][z+T][1]+CX[i+T][j+T][z+T][2]+CX[i+T][j+T][z+T][3];
                    p12=CY[i+T][j+T][z+T][0]+CY[i+T][j+T][z+T][1]+CY[i+T][j+T][z+T][2]+CY[i+T][j+T][z+T][3];

                    p21=CX[i+T][j+T][z+T][4]+CX[i+T][j+T][z+T][5]+CX[i+T][j+T][z+T][6]+CX[i+T][j+T][z+T][7];
                    p22=CY[i+T][j+T][z+T][4]+CY[i+T][j+T][z+T][5]+CY[i+T][j+T][z+T][6]+CY[i+T][j+T][z+T][7];

                    distortion=distortion+wc*Math.abs(p11 - p12)+wc*Math.abs(p21 - p22);
        }

          return distortion;

    }


    public double getDistortion2(int [][]X,int [][]Y)
    {
        double distortion=0,wc,p11,p12,p21,p22;
        double [][][]    CX = getC2(getD(X));
        double [][][]    CY = getC2(getD(Y));

        int i,j,z;


        for (i=-T;i<=T;i++)
            for (j=-T;j<=T;j++)
                {
                    wc=w(i,j);
                    p11=CX[i+T][j+T][0]+CX[i+T][j+T][1]+CX[i+T][j+T][2]+CX[i+T][j+T][3];
                    p12=CY[i+T][j+T][0]+CY[i+T][j+T][1]+CY[i+T][j+T][2]+CY[i+T][j+T][3];

                    p21=CX[i+T][j+T][4]+CX[i+T][j+T][5]+CX[i+T][j+T][6]+CX[i+T][j+T][7];
                    p22=CY[i+T][j+T][4]+CY[i+T][j+T][5]+CY[i+T][j+T][6]+CY[i+T][j+T][7];

                    distortion=distortion+wc*Math.abs(p11-p12)+wc*Math.abs(p21-p22);
                }

        return distortion;

    }

    public double[][] getDistortion2Full(int [][]X,int [][]Y)
    {
        double distortion=0,wc,p11,p12,p21,p22;
        double [][][]    CX = getC2(getD(X));
        double [][][]    CY = getC2(getD(Y));
        double [][] deltaCXY = new double[2*T+1][2*T+1];

        int i,j,z;


        for (i=-T;i<=T;i++)
            for (j=-T;j<=T;j++)
            {
                wc=w(i,j);
                p11=CX[i+T][j+T][0]+CX[i+T][j+T][1]+CX[i+T][j+T][2]+CX[i+T][j+T][3];
                p12=CY[i+T][j+T][0]+CY[i+T][j+T][1]+CY[i+T][j+T][2]+CY[i+T][j+T][3];

                p21=CX[i+T][j+T][4]+CX[i+T][j+T][5]+CX[i+T][j+T][6]+CX[i+T][j+T][7];
                p22=CY[i+T][j+T][4]+CY[i+T][j+T][5]+CY[i+T][j+T][6]+CY[i+T][j+T][7];

                deltaCXY[i+T][j+T]=(p12+p22)-(p11+p21);

            }

        return deltaCXY;

    }


    public double getDistortion3Smart(int [][]X,int [][]Y,int [][][] oldDX,int [][][] oldDY,double[][][][] oldCX,double[][][][] oldCY, int iChanged,int jChanged)
    {
        double distortion=0,wc,p11,p12,p21,p22;
      //  double [][][][]    CX = recalculateC3(oldDX,recalculateD(X,oldDX,iChanged,jChanged),oldCX,iChanged,jChanged);
        double [][][][]    CX = oldCX;
        double [][][][]    CY = recalculateC3(oldDY,recalculateD(Y,oldDY,iChanged,jChanged),oldCY,iChanged,jChanged);

        int i,j,z;


        for (i=-T;i<=T;i++)
            for (j=-T;j<=T;j++)
                for (z=-T;z<=T;z++)
                {
                    wc=w(i,j,z);
                    p11=CX[i+T][j+T][z+T][0]+CX[i+T][j+T][z+T][1]+CX[i+T][j+T][z+T][2]+CX[i+T][j+T][z+T][3];
                    p12=CY[i+T][j+T][z+T][0]+CY[i+T][j+T][z+T][1]+CY[i+T][j+T][z+T][2]+CY[i+T][j+T][z+T][3];

                    p21=CX[i+T][j+T][z+T][4]+CX[i+T][j+T][z+T][5]+CX[i+T][j+T][z+T][6]+CX[i+T][j+T][z+T][7];
                    p22=CY[i+T][j+T][z+T][4]+CY[i+T][j+T][z+T][5]+CY[i+T][j+T][z+T][6]+CY[i+T][j+T][z+T][7];

                    distortion=distortion+wc*Math.abs(p11 - p12)+wc*Math.abs(p21 - p22);
                }

        return distortion;

    }


    public double getDistortion2Smart(int [][]X,int [][]Y,int [][][] oldDX,int [][][] oldDY,double[][][] oldCX,double[][][] oldCY, int iChanged,int jChanged)
    {
        double distortion=0,wc,p11,p12,p21,p22,p1,p2;
       // double [][][]    CX = recalculateC2(oldDX,recalculateD(X,oldDX,iChanged,jChanged),oldCX,iChanged,jChanged);
        double [][][]    CX = oldCX;
        double [][][]    CY = recalculateC2(oldDY,recalculateD(Y,oldDY,iChanged,jChanged),oldCY,iChanged,jChanged);

        int i,j,z;


        for (i=-T;i<=T;i++)
            for (j=-T;j<=T;j++)
                {
                    wc=w(i,j);


                    p11=CX[i+T][j+T][0]+CX[i+T][j+T][1]+CX[i+T][j+T][2]+CX[i+T][j+T][3];
                    p12=CY[i+T][j+T][0]+CY[i+T][j+T][1]+CY[i+T][j+T][2]+CY[i+T][j+T][3];

                    p21=CX[i+T][j+T][4]+CX[i+T][j+T][5]+CX[i+T][j+T][6]+CX[i+T][j+T][7];
                    p22=CY[i+T][j+T][4]+CY[i+T][j+T][5]+CY[i+T][j+T][6]+CY[i+T][j+T][7];


                   /*
                    p11=CX[i+T][j+T][0];
                    p12=CY[i+T][j+T][0];

                    p21=0;
                    p22=0;
                    */
                    if(signed==0)
                        distortion=distortion+wc*Math.abs(p11 - p12)+wc*Math.abs(p21 - p22);
                    else if(signed==1)
                        distortion=distortion+wc*(p12 - p11)+wc*(p22 - p21);
                    else if(signed==2)
                        distortion=distortion+wc*(p11 - p12)+wc*(p21 - p22);
                    else if(signed==3)
                    {
                        p1=p12-p11;
                        p2=p22-p21;
                        if(p1<0) p1=0;
                        if(p2<0) p2=0;
                        distortion=distortion+wc*p1+wc*p2;
                    }
                    else if(signed==4)
                    {
                        p1=p11-p12;
                        p2=p21-p22;
                        if(p1<0) p1=0;
                        if(p2<0) p2=0;
                        distortion=distortion+wc*p1+wc*p2;
                    }
                    else if(signed==5)
                    {
                        distortion=distortion+rand(probability)*wc*(p11 - p12)+rand(probability)*wc*(p21 - p22);
                    }
                    else if(signed==6)
                    {
                        double rndSign=rand(probability) ;
                        distortion=distortion+rndSign*wc*(p11 - p12)+rndSign*wc*(p21 - p22);
                    }
                }

        return distortion;

    }


    public double getDistortion(int [][]X,int [][]Y,int dim)
    {
        double distortion=0;

        if(dim==2)
            distortion=getDistortion2(X,Y);
        else if(dim==3)
            distortion=getDistortion3(X,Y);


        return distortion;

    }

    private double w(int d1,int d2,int d3)
    {
        double W;
        W=1/(Math.pow(Math.sqrt(Math.pow(d1,2)+Math.pow(d2,2)+Math.pow(d3,2))+sigma,gamma));
        return W;
    }
    private double w(int d1,int d2)
    {
        double W,W1,W2;
        W=0;
        if(weightForm==1)
            W=1/(Math.pow(Math.sqrt(Math.pow(d1,2)+Math.pow(d2,2))+sigma,gamma));
        else if(weightForm==2){
            W1=1/(Math.pow(Math.sqrt(Math.pow(d1-shift,2)+Math.pow(d2+shift,2))+sigma,gamma));
            W2=1/(Math.pow(Math.sqrt(Math.pow(d1+shift,2)+Math.pow(d2-shift,2))+sigma,gamma));
            W=(W1+W2)/2; }
        else if(weightForm==3){

                if((d1==-d2)&&(Math.abs(d1)==2) )
                    W=10000;
                else if((d1==-2 && d2==1)||(d1==-1 && d2==2))
                    W=10000;
                else
                    W=0;
        }
        else if(weightForm==4)
        {
            W=weight2d[d1+T][d2+T];
        }
        else if(weightForm==5)
        {
            W=weight2d[d1+T][d2+T]/(Math.pow(Math.sqrt(Math.pow(d1,2)+Math.pow(d2,2))+sigma,gamma));
        }
        else
        return 0;

        return W;
    }

   public double rand(double p)
    {
        int v;

        int max=1000000;

        v= (int)(Math.random() * (max + 1));
        if (v<(double)max*p)
            return 1;
        return -1;
    }

    public double rand()
    {
        return (rand(0.5));
    }
}
