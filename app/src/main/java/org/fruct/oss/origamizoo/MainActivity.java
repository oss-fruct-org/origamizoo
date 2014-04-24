package org.fruct.oss.origamizoo;

import android.app.Activity;
import android.content.Context;
import android.content.SharedPreferences;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.res.AssetManager;
import android.content.res.Resources;
import android.graphics.Typeface;
import android.graphics.drawable.Drawable;
import android.os.Build;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.view.PagerAdapter;
import android.support.v4.view.ViewPager;
import android.support.v7.app.ActionBarActivity;
import android.util.Log;
import android.view.*;
import android.widget.*;
import com.readystatesoftware.systembartint.SystemBarTintManager;

import java.util.ArrayList;
import java.util.List;


public class MainActivity extends ActionBarActivity {

    public static String SHARED_PREFS = "origamizooprefs";
    public static String SHARED_PREFS_OPENED_TIMES = "openedtimes";
    static SharedPreferences settings;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        if (savedInstanceState == null) {
            getSupportFragmentManager().beginTransaction()
                    .add(R.id.container, new MainMenuFragment())
                    .commit();
        }

        settings = getSharedPreferences(SHARED_PREFS, 0);

        if (Build.VERSION.SDK_INT >= 19) {
            Window w = getWindow();
            w.setFlags(67108864, 67108864);

            SystemBarTintManager tintManager = new SystemBarTintManager(this);
            tintManager.setStatusBarTintEnabled(true);
            tintManager.setTintColor(getResources().getColor(R.color.global_blue));
            tintManager.setStatusBarAlpha(100);
        }


    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();
        if (id == R.id.action_about) {
            AboutFragment fragment = new AboutFragment();
            getSupportFragmentManager()
                    .beginTransaction()
                    .replace(R.id.container, fragment)
                    .addToBackStack("main")
                    .setTransition(R.anim.abc_fade_in)
                    .commit();

            return true;
        }

        if (id == android.R.id.home) {
            getSupportFragmentManager().popBackStack();
            return true;
        }
        if (id == R.id.action_help) {

            HelpFragment fragment = new HelpFragment();
            getSupportFragmentManager()
                    .beginTransaction()
                    .replace(R.id.container, fragment)
                    .addToBackStack("instruction")
                    .setTransition(R.anim.abc_slide_in_bottom)
                    .commit();
        }

        return super.onOptionsItemSelected(item);
    }


    public static class MainMenuFragment extends Fragment {

        public MainMenuFragment() {
        }

        @Override
        public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
            View rootView = inflater.inflate(R.layout.fragment_main, container, false);

            ArrayList<OrigamiInfo> array = new ArrayList<OrigamiInfo>();

            Resources res = getResources();
            String[] figNames = res.getStringArray(R.array.figures_names);
            String[] figSteps = res.getStringArray(R.array.figures_steps_toshow);
            String[] figRealSteps = res.getStringArray(R.array.figures_steps_real);
            String[] figComplexity = res.getStringArray(R.array.figures_complexity);
            String[] figCodeNames = res.getStringArray(R.array.figures_folder);

            for (int i = 0; i < figNames.length; i++) {
                OrigamiInfo info = new OrigamiInfo();

                info.name = figNames[i];
                info.complexity = Integer.parseInt(figComplexity[i]);
                info.totalSteps = Integer.parseInt(figSteps[i]);
                info.realSteps = Integer.parseInt(figRealSteps[i]);
                info.folder = figCodeNames[i];
                info.image = res.getDrawable(res.getIdentifier("ic_" + info.folder, "drawable", getActivity().getPackageName()));

                array.add(i, info);
            }

            final OrigamiMainAdapter adapter = new OrigamiMainAdapter(getActivity(), array);
            ListView list = (ListView) rootView.findViewById(R.id.main_list);
            list.setAdapter(adapter);

            list.setOnItemClickListener(new AdapterView.OnItemClickListener() {
                @Override
                public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                    OrigamiInfo info = (OrigamiInfo) adapter.getItem(position);

                    InstructionFragment fragment = new InstructionFragment(info.name, info.folder, info.complexity, info.totalSteps, info.realSteps);
                    getActivity().getSupportFragmentManager()
                            .beginTransaction()
                            .replace(R.id.container, fragment)
                            .addToBackStack("main")
                            .commit();

                }
            });

            android.support.v7.app.ActionBar actionBar = ((ActionBarActivity)getActivity()).getSupportActionBar();
            if (actionBar != null) {
                actionBar.setDisplayHomeAsUpEnabled(false);
                actionBar.setTitle(getString(R.string.app_name));
            }

            return rootView;
        }

        /**
         * Load JSON from assets folder
         * @ filename name of file to load
         * @ cont context
         * @return loaded string
         *
         * CODE FROM TOURME
         */
/*        public static String loadJSONFromAsset(String filename, Context cont) {
            String json;
            try {
                InputStream is = cont.getAssets().open(filename);
                int size = is.available();
                byte[] buffer = new byte[size];
                is.read(buffer);
                is.close();
                json = new String(buffer, "UTF-8");
            } catch (IOException ex) {
                ex.printStackTrace();
                return null;
            }

            return json;
        }*/

        public class OrigamiInfo {
            public String name;
            public String folder;
            public int complexity;
            public int totalSteps;
            public int realSteps;
            Drawable image;
        }

        static class ViewHolder {
            ImageView image;
            TextView title;
            TextView steps;
            LinearLayout complexity;
        }


        public class OrigamiMainAdapter extends BaseAdapter {

            List<OrigamiInfo> elements;
            private Context mContext;

            public OrigamiMainAdapter(Context c, List<OrigamiInfo>elements) {
                super();
                mContext = c;

                this.elements = elements;
            }

            public int getCount() {
                return elements.size();
            }

            public Object getItem(int position) {
                return elements.get(position);
            }

            public long getItemId(int position) {
                return position;
            }

            public View getView(int position, View convertView, ViewGroup parent) {

                ViewHolder holder;

                if (convertView == null) {
                    LayoutInflater inflater = (LayoutInflater) mContext.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
                    convertView = inflater.inflate(R.layout.origami_main_list_item, parent, false);

                    holder = new ViewHolder();
                    holder.image = (ImageView) convertView.findViewById(R.id.origami_list_item_preview);
                    holder.title = (TextView) convertView.findViewById(R.id.origami_list_item_name);
                    holder.steps = (TextView) convertView.findViewById(R.id.origami_list_item_steps);
                    holder.complexity = (LinearLayout) convertView.findViewById(R.id.origami_list_item_complexity_layout);

                    convertView.setTag(holder);
                } else {
                    holder = (ViewHolder) convertView.getTag();
                }

                OrigamiInfo info = elements.get(position);

                holder.title.setText(info.name);
                holder.steps.setText(String.format(mContext.getString(R.string.list_item_steps), info.totalSteps));
                holder.image.setImageDrawable(info.image);

                holder.complexity.removeAllViews();
                for (int i = 1; i <= info.complexity; i++) {
                    ImageView star = new ImageView(getActivity());
                    star.setImageDrawable(getActivity().getResources().getDrawable(R.drawable.ic_comlexity));
                    holder.complexity.addView(star);
                }

                return convertView;

            }
        }

    }


    public static class InstructionFragment extends Fragment {

        public InstructionFragment() {
        }

        private String name;
        private String folder;
        //private int step; // Actually this can be not equal with the steps at previous fragment
        private int totalSteps;
        private int realSteps; // real value, not value to show
        private int complexity;

        public InstructionFragment(String name, String folder, int complexity, int shownSteps, int _realSteps) {
        //public InstructionFragment(String name, String folder, int complexity) {
            this.name = name;
            this.folder = folder;
            //this.step = _step;
            this.realSteps = _realSteps;
            this.complexity = complexity;
            Log.e("origamizoo", " " + folder + " " + shownSteps + " " + _realSteps);
        }


        /**
         * Class for one portion of data
         */
        class Instruction {
            String description = null;
            Drawable imageResource;
            int position;
            //int step;
            int totalSteps;

            public Instruction() {
            }

            //public Instruction(String _description, Drawable _imageResource, int _pos) {
            public Instruction(String _description, Drawable _imageResource, int _step, int _steps) {
                description = _description;
                imageResource = _imageResource;
                position = _step;
                //this.step = _step;
                this.totalSteps = _steps;
            }
        }


        /**
         * This class represents view for the Instruction (Image + Caption)
         * Use it with ViewPager
         */
        class InstructionView extends LinearLayout {
            //public InstructionView(Context context, Drawable drawable, String descriptionText) {
            public InstructionView(Context context, Drawable drawable, String descriptionText, int currentStep, int totalSteps) {
                super(context);

                LayoutInflater inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
                inflater.inflate(R.layout.instruction_view, this);

                ImageView image = (ImageView) findViewById(R.id.instruction_view_image);
                image.setImageDrawable(drawable);

                TextView description = (TextView) findViewById(R.id.instruction_view_text);
                description.setText(descriptionText+" "); // Little work around to fix especial typeface

                //TextView stepsView = (TextView) findViewById(R.id.instruction_steps);
                //Log.e("origami", currentStep + " /" + totalSteps);
                //stepsView.setText(currentStep + "/" + totalSteps);

                // Especial font for latest screen
                if (descriptionText.equals(context.getString(R.string.finished))) {
                    Typeface typeface = Typeface.createFromAsset(getActivity().getAssets(), "font.ttf");
                    description.setTypeface(typeface);
                    description.setTextSize(50);
                    //stepsView.setVisibility(GONE);
                }
            }
        }

        public class InstructionAdapter extends PagerAdapter {

            Context context;



            private ArrayList<Instruction> items;

            public InstructionAdapter(Context context, ArrayList<Instruction> items) {
                this.context = context;
                this.items = items;
            }

            @Override
            public int getCount() {
                return items.size();
            }

            @Override
            public boolean isViewFromObject(View view, Object object) {
                return view == ((InstructionView) object);
            }

            @Override
            public Object instantiateItem(ViewGroup container, int position) {
                Instruction currentInstruction = items.get(position);
                InstructionView view = new InstructionView(context, currentInstruction.imageResource, currentInstruction.description, currentInstruction.position, currentInstruction.totalSteps);

                ((ViewPager) container).addView(view, 0);
                return view;
            }

            @Override
            public void destroyItem(ViewGroup container, int position, Object object) {
                ((ViewPager) container).removeView((InstructionView) object);
            }
        }

        /**
         *
         *
         *
         */


        @Override
        public void onCreate(Bundle savedInstanceState) {
            super.onCreate(savedInstanceState);
            setRetainInstance(true);
        }

        @Override
        public void onDestroy() {
            super.onDestroy();
        }


        @Override
        public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
            super.onCreateView(inflater, container, savedInstanceState);

            View rootView = inflater.inflate(R.layout.fragment_instruction, container, false);

            // Show instruction only first 3 times
            if (settings.getInt(SHARED_PREFS_OPENED_TIMES, 0) == 0) {
                final RelativeLayout overlayLayout = (RelativeLayout) rootView.findViewById(R.id.instruction_overlay_layout);
                overlayLayout.setVisibility(View.VISIBLE);

                Button okButton = (Button) rootView.findViewById(R.id.instruction_overlay_ok);
                okButton.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        overlayLayout.setVisibility(View.GONE);
                    }
                });

                SharedPreferences.Editor editor = settings.edit();
                editor.putInt(SHARED_PREFS_OPENED_TIMES, settings.getInt(SHARED_PREFS_OPENED_TIMES, 0) + 1);
                editor.commit();
            }


            android.support.v7.app.ActionBar actionBar = ((ActionBarActivity)getActivity()).getSupportActionBar();
            if (actionBar != null) {
                actionBar.setDisplayHomeAsUpEnabled(true);
                actionBar.setTitle(name);
            }

            ViewPager pager = (ViewPager) rootView.findViewById(R.id.instructions_pager);


            /**
             *
             * Parse JSON for current figure, collect data
             *
             */
            ArrayList<Instruction> list = new ArrayList<Instruction>();

            Instruction instructionFinish = new Instruction(
                    getResources().getString(R.string.finished),
                    getResources().getDrawable(
                            getResources().getIdentifier(this.folder, "drawable", getActivity().getPackageName())
                    ),
                    totalSteps, totalSteps);

            String path = "/assets/figures/" + this.folder + "/";
            AssetManager assets = getActivity().getAssets();
            Activity activity = getActivity();
            Resources res = getResources();

            for (int i = 1; i <= this.realSteps; i++) {
                Log.d("origami", "for=");

                int resId = res.getIdentifier(this.folder + "_" + i, "string", activity.getPackageName());


                try {
                    Log.d("origami", res.getString(resId));
                    Log.d("origami", path + "step" + i);
                    Log.d("origami", " " + Drawable.createFromStream(activity.getClass().getResourceAsStream(path + "step" + i), null));
                    Instruction instruction = new Instruction(
                        res.getString(resId),
                        Drawable.createFromStream(activity.getClass().getResourceAsStream(path + "step" + i + ".png"), null),
                        0,
                        this.totalSteps
                    );

                    list.add(instruction);

                } catch (Exception e) {
                    Log.e("origamizoo", e.toString() + " ");
                }

            }

            list.add(instructionFinish);


            InstructionAdapter adapter = new InstructionAdapter(getActivity(), list);
            pager.setAdapter(adapter);

            return rootView;
        }
    }

















    /**
     *
     * About fragment
     *
     *
     */
    public static class AboutFragment extends Fragment {
        public AboutFragment() {
        }

        @Override
        public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
            View rootView = inflater.inflate(R.layout.fragment_about, container, false);

            TextView aboutTitle = (TextView) rootView.findViewById(R.id.about_title);
            Typeface typeface = Typeface.createFromAsset(getActivity().getAssets(), "font.ttf");
            aboutTitle.setTypeface(typeface);

            TextView versionText = (TextView) rootView.findViewById(R.id.about_version);
            String version = null;

            PackageInfo pInfo = null;
            try {
                pInfo = getActivity().getPackageManager().getPackageInfo(getActivity().getPackageName(), 0);
                version = pInfo.versionName;
            } catch (PackageManager.NameNotFoundException e) {
                e.printStackTrace();
            }

            if (version != null)
                versionText.setText(String.format(getString(R.string.about_version), version));
            else
                versionText.setVisibility(View.GONE);

            android.support.v7.app.ActionBar actionBar = ((ActionBarActivity)getActivity()).getSupportActionBar();
            if (actionBar != null) {
                actionBar.setDisplayHomeAsUpEnabled(true);
                actionBar.setTitle(getString(R.string.action_about));
            }


            return rootView;
        }


    }


    /**
     *
     * Help fragment
     *
     */
    public static class HelpFragment extends Fragment {

        public HelpFragment() {
        }

        @Override
        public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
            View rootView = inflater.inflate(R.layout.fragment_help, container, false);

            android.support.v7.app.ActionBar actionBar = ((ActionBarActivity)getActivity()).getSupportActionBar();
            if (actionBar != null) {
                actionBar.setDisplayHomeAsUpEnabled(true);
                actionBar.setTitle(getString(R.string.action_help));
            }

            return rootView;
        }

    }




// End of Activity
}
