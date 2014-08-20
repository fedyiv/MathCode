import java.io.File;
import java.io.FilenameFilter;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * Created with IntelliJ IDEA.
 * User: Ivan
 * Date: 28.12.13
 * Time: 12:17
 * To change this template use File | Settings | File Templates.
 */
public class HugoExecutor {
    int nThreads;
    String imageDirectory;
    int dim,T,weightForm,signed;
    double gamma,sigma;
    double [][]weighMatrix;
    double probability;
    public HugoExecutor(int nThreads,String imageDirectory,int dim,int T,double gamma,double sigma,int weightForm,double [][]weighMatrix,int signed)
    {
        this.nThreads=nThreads;
        this.imageDirectory=imageDirectory;
        this.dim=dim;
        this.T=T;
        this.gamma=gamma;
        this.sigma=sigma;
        this.weightForm=weightForm;
        this.weighMatrix=weighMatrix;
        this.signed=signed;
        this.probability=1;

    }
    public HugoExecutor(int nThreads,String imageDirectory,int dim,int T,double gamma,double sigma,int weightForm,double [][]weighMatrix,int signed,double probability)
    {
        this.nThreads=nThreads;
        this.imageDirectory=imageDirectory;
        this.dim=dim;
        this.T=T;
        this.gamma=gamma;
        this.sigma=sigma;
        this.weightForm=weightForm;
        this.weighMatrix=weighMatrix;
        this.signed=signed;
        this.probability=probability;

    }
    public void calculateAllCosts()
    {
        File dir = new File(imageDirectory);


        File[] files = dir.listFiles(new FilenameFilter() {
            public boolean accept(File dir, String name) {
                return name.toLowerCase().endsWith(".pgm");
            }
        });


        ExecutorService executor = Executors.newFixedThreadPool(nThreads);

        for (int i = 0; i < files.length; i++) {

            try
            {
            PGM image=new PGM(files[i].getPath());
            image.read();

            Runnable worker = new HugoWorker(dim,T,gamma,sigma,weightForm,weighMatrix,image.imageBitmap,files[i].getPath(),signed,probability);

            executor.execute(worker);
            }

            catch(Exception e)
            {
                System.out.println(e);
            }

        }

        executor.shutdown();

        while (!executor.isTerminated()) {        }
        System.out.println("Finished all threads");
    }
}
