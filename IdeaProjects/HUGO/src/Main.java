public class Main {

    public static void main(String[] args) throws Exception {
	// write your code here
        System.out.println("Hello World!");

        long time = System.currentTimeMillis();


        HugoExecutor he;
   //     he=new HugoExecutor(5,"D:/work/hugoJ/cm2d/16/train/",2,3,4,10,1,null);

     //   he.calculateAllCosts();




        double completedIn = ((double)(System.currentTimeMillis() - time))/1000.0;
        System.out.println("\n PAR:Completed in :" +  completedIn);




    }
}
