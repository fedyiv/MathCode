/**
 * Created with IntelliJ IDEA.
 * User: Ivan
 * Date: 27.12.13
 * Time: 21:20
 * To change this template use File | Settings | File Templates.
 */


import java.io.DataOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;

public class HugoWorker implements Runnable {

    public HUGO hugo;
    int [][]I;
    int dim,T;
    double gamma,sigma;
    double [][][]Costs;
    String path;
    int weightForm;
    int signed;


    public HugoWorker(int dim,int T,double gamma,double sigma,int weightForm,double [][]weighMatrix,int [][]I,String path,int signed)
    {
        this.I=I;
        this.dim=dim;
        this.T=T;
        this.path=path;
        this.sigma=sigma;
        this.gamma=gamma;
        this.signed=signed;
        this.weightForm=weightForm;

        hugo= new HUGO(T,gamma,sigma,weightForm,weighMatrix,signed);

    }

    public HugoWorker(int dim,int T,double gamma,double sigma,int weightForm,double [][]weighMatrix,int [][]I,String path,int signed,double probability)
    {
        this.I=I;
        this.dim=dim;
        this.T=T;
        this.path=path;
        this.sigma=sigma;
        this.gamma=gamma;
        this.signed=signed;
        this.weightForm=weightForm;

        hugo= new HUGO(T,gamma,sigma,weightForm,weighMatrix,signed,probability);

    }

    public void run()
    {



        File file=new File(path);
        String dir=file.getParent();
        String name=file.getName();

        String [] temp=name.split("\\.");
        String fileName=temp[0];



        File costsDir = new File(dir+"/Costs");
        if (!costsDir.exists() || !costsDir.isDirectory())
        {
            costsDir.mkdir();
        }


        String costsFileName=dir+"/Costs/"+fileName+"d_"+dim +"T_" +T + "sigma_" +  num2str(sigma) +"gamma_" + num2str(gamma)+"wf_" + num2str(weightForm)+ "sign_" + num2str(signed)+".costs5";

        File costFile=new File(costsFileName);
        if(costFile.exists())
            return;


        Costs=hugo.getCostsSmart(I,dim);

        try {
        FileOutputStream fos= new FileOutputStream(costsFileName);
        DataOutputStream dos = new DataOutputStream(fos);

            int nRows=Costs.length;
            int nCols=Costs[0].length;
            int nMx=Costs[0][0].length;

            for(int mx=0;mx<=1;mx++)
            {
                for (int col = 0; col < nCols; col++)
                {
                    for (int row = 0; row < nCols; row++)
                    {
                        dos.writeDouble(reverse(Costs[row][col][mx]));
                    }
                }
            }

            dos.flush();
            fos.close();
        }
        catch(Exception e)
        {

        }


    }

    public static String num2str(double d)
    {
        if(d == (int) d)
            return String.format("%d",(int)d);
        else
            return String.format("%s",d);
    }

    public static double reverse(double x) {
        return ByteBuffer.allocate(8)
                .order(ByteOrder.BIG_ENDIAN).putDouble(x)
                .order(ByteOrder.LITTLE_ENDIAN).getDouble(0);
    }

}
