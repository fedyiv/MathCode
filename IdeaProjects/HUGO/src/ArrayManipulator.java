/**
 * Created with IntelliJ IDEA.
 * User: Ivan
 * Date: 18.07.13
 * Time: 18:43
 * To change this template use File | Settings | File Templates.
 */
import java.util.Arrays;
public class ArrayManipulator {
    public ArrayManipulator()
    {}

    public void printArray(int [][][] Arr)
    {
        int i,j,k,n,m,z;

        n =Arr.length;
        m =Arr[0].length;
        z =Arr[0][0].length;

        for (k=0;k<z;k++)
        {    System.out.println("\nArray[][][" +k+"]");
            for (i=0;i<n;i++)
            {
                //System.out.println("\nArray[][" + j +"][" +k+"]\n");
                System.out.println("\n");
                for (j=0;j<m;j++)
                {
                    System.out.printf("%7d ",Arr[i][j][k]);
                }
            }
        }
    }

    public void printArray(int [][][] Arr,int k)
    {
        int i,j,n,m,z;

        n =Arr.length;
        m =Arr[0].length;
        z =Arr[0][0].length;


            System.out.println("\nArray[][][" +k+"]");
            for (i=0;i<n;i++)
            {
                //System.out.println("\nArray[][" + j +"][" +k+"]\n");
                System.out.println("\n");
                for (j=0;j<m;j++)
                {
                    System.out.printf("%7d ",Arr[i][j][k]);
                }
            }

    }

    public void printArray(double [][][] Arr)
    {
        int i,j,k,n,m,z;

        n =Arr.length;
        m =Arr[0].length;
        z =Arr[0][0].length;

        for (k=0;k<z;k++)
        {    System.out.println("\nArray[][][" +k+"]");
            for (i=0;i<n;i++)
            {
                //System.out.println("\nArray[][" + j +"][" +k+"]\n");
                System.out.println("\n");
                for (j=0;j<m;j++)
                {
                    System.out.printf("%15.11f ",Arr[i][j][k]);
                }
            }
        }
    }

    public void printArray(double [][][] Arr, int k)
    {
        int i,j,n,m,z;

        n =Arr.length;
        m =Arr[0].length;
        z =Arr[0][0].length;


        System.out.println("\nArray[][][" +k+"]");
        for (i=0;i<n;i++)
        {
            //System.out.println("\nArray[][" + j +"][" +k+"]\n");
            System.out.println("\n");
            for (j=0;j<m;j++)
            {
                System.out.printf("%7.3f ",Arr[i][j][k]);
            }
        }

    }

    public void printArray(double [][][][] Arr)
    {
        int i,j,k,n,m,z;

        n =Arr.length;
        m =Arr[0].length;
        z =Arr[0][0].length;

        return;
         /*
        for (k=0;k<z;k++)
        {    System.out.println("\nArray[][][" +k+"]");
            for (i=0;i<n;i++)
            {
                //System.out.println("\nArray[][" + j +"][" +k+"]\n");
                System.out.println("\n");
                for (j=0;j<m;j++)
                {
                    System.out.printf("%7.3f ",Arr[i][j][k]);
                }
            }
        }  */
    }

    public boolean equals(double []A1,double []A2)
    {
        int n1,n2,i;
        n1=A1.length;
        n2=A2.length;

        if(n1!=n2)
            return false;

        for(i=0;i<n1;i++)
            if(A1[i]!=A2[i])
                return false;

        return true;
    }

    public boolean equals(double [][]A1,double [][]A2)
    {
        int n1,n2,i;
        n1=A1.length;
        n2=A2.length;

        if(n1!=n2)
            return false;

        for(i=0;i<n1;i++)
            if(!equals(A1[i],A2[i]))
                return false;

        return true;
    }

    public boolean equals(double [][][]A1,double [][][]A2)
    {
        int n1,n2,i;
        n1=A1.length;
        n2=A2.length;

        if(n1!=n2)
            return false;

        for(i=0;i<n1;i++)
            if(!equals(A1[i],A2[i]))
                return false;

        return true;
    }

    public boolean equals(double [][][][]A1,double [][][][]A2)
    {
        int n1,n2,i;
        n1=A1.length;
        n2=A2.length;

        if(n1!=n2)
            return false;

        for(i=0;i<n1;i++)
            if(!equals(A1[i],A2[i]))
                return false;

        return true;
    }

    public boolean equals(int []A1,int []A2)
    {
        int n1,n2,i;
        n1=A1.length;
        n2=A2.length;

        if(n1!=n2)
            return false;

        for(i=0;i<n1;i++)
            if(A1[i]!=A2[i])
                return false;

        return true;
    }

    public boolean equals(int [][]A1,int [][]A2)
    {
        int n1,n2,i;
        n1=A1.length;
        n2=A2.length;

        if(n1!=n2)
            return false;

        for(i=0;i<n1;i++)
            if(!equals(A1[i],A2[i]))
                return false;

        return true;
    }

    public boolean equals(int [][][]A1,int [][][]A2)
    {
        int n1,n2,i;
        n1=A1.length;
        n2=A2.length;

        if(n1!=n2)
            return false;

        for(i=0;i<n1;i++)
            if(!equals(A1[i],A2[i]))
                return false;

        return true;
    }

    public boolean equals(int [][][][]A1,int [][][][]A2)
    {
        int n1,n2,i;
        n1=A1.length;
        n2=A2.length;

        if(n1!=n2)
            return false;

        for(i=0;i<n1;i++)
            if(!equals(A1[i],A2[i]))
                return false;

        return true;
    }

    public static int [][] copyByVal(int [][] A)
    {
        int i,n;
        n=A.length;

        int [][] B= new int[n][];

        for(i=0;i<n;i++)
            B[i]=Arrays.copyOf(A[i],A[i].length);

        return B;

    }

    public static int [][][] copyByVal(int [][][] A)
    {
        int i,n;
        n=A.length;

        int [][][] B= new int[n][][];

        for(i=0;i<n;i++)
            B[i]=copyByVal(A[i]);

        return B;

    }

    public static double [][] copyByVal(double [][] A)
    {
        int i,n;
        n=A.length;

        double [][] B= new double[n][];

        for(i=0;i<n;i++)
            B[i]=Arrays.copyOf(A[i],A[i].length);

        return B;

    }

    public static double [][][] copyByVal(double [][][] A)
    {
        int i,n;
        n=A.length;

        double [][][] B= new double[n][][];

        for(i=0;i<n;i++)
            B[i]=copyByVal(A[i]);

        return B;

    }

    public static double [][][][] copyByVal(double [][][][] A)
    {
        int i,n;
        n=A.length;

        double [][][][] B= new double[n][][][];

        for(i=0;i<n;i++)
            B[i]=copyByVal(A[i]);

        return B;

    }

    public static double[] multiplyMatrixByScalar(double [] A,double k)
    {
        int length=A.length,i;
        double [] B = new double[A.length];

        for(i=0;i<length;i++)
            B[i]=A[i]*k;

        return B;
    }

    public static double[][] multiplyMatrixByScalar(double [][] A,double k)
    {
        double [][] B = new double[A.length][];

        for(int i=0;i<A.length;i++)
            B[i]=multiplyMatrixByScalar(A[i],k);

        return B;
    }

    public static double[][][] multiplyMatrixByScalar(double [][][] A,double k)
    {
        double [][][] B = new double[A.length][][];

        for(int i=0;i<A.length;i++)
            B[i]=multiplyMatrixByScalar(A[i],k);

        return B;
    }

    public static double[][][][] multiplyMatrixByScalar(double [][][][] A,double k)
    {
        double [][][][] B = new double[A.length][][][];

        for(int i=0;i<A.length;i++)
            B[i]=multiplyMatrixByScalar(A[i],k);

        return B;
    }


}
