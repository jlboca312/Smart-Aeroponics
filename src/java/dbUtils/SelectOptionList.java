
package dbUtils;


public class SelectOptionList {
    
    public SelectOption[] list = null;
    public int listSize = 0;
    private int addIndex = 0;
    public String dbError = "";

    public SelectOptionList(int listSize) {
        this.listSize = listSize;
        this.list = new SelectOption[listSize];
    }

    public boolean addOption(SelectOption option) {
        if (this.addIndex < this.listSize) {
            this.list[addIndex] = option;
            this.addIndex++;
            return true;
        } else {
            System.out.println("***** dbUtils SelectOptionList: Attempt to add option " +
                    this.addIndex + " to list of size " + this.listSize);
            return false;
        }
    }
    
}
