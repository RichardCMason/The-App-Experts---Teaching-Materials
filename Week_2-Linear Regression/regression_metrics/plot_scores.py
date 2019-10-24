
import sklearn.metrics as metrics
import sklearn.linear_model as linear_model
import pandas as pd
from matplotlib.pyplot import *

def get_scores(y_true, y_hat):
    scores = {
        "MSE":   round(metrics.mean_squared_error(y_true, y_hat), 3),
        "MAE":   round(metrics.mean_absolute_error(y_true, y_hat), 3),
        "MedAE": round(metrics.median_absolute_error(y_true, y_hat), 3),
        "RMSE":  round(metrics.mean_squared_error(y_true, y_hat) ** 0.5, 3),
        "R2":    round(metrics.r2_score(y_true, y_hat), 3),
        
    }
    
    # You can tune a piano, but you can't tunafish. (negative numbers in logs)
    try: 
        scores["MSLE"] = round(metrics.mean_squared_log_error(y_true, y_hat), 3)
    except:
        scores["MSLE"] = "log(-n)"
        
    return scores
        
    
def plot_scores(df, kind = "scatter", residuals = False):
    """
    This plot function requires the existance of the features "y" and "y_hat" to work properly
    """
    fig, ax = subplots(nrows=1, ncols=2, figsize=(15, 5))

    # Plotting the metric scores
    scores = get_scores(df['y'], df['y_hat'])

    methods = ("MSE", "MAE", "MedAE", "RMSE", "MSLE", "R2")
    score_legend = "\n".join(["{0:<8}{{{0}}}".format(method) for method in methods])
    
    ax[1].annotate(
        score_legend.format(**scores), 
        xy        = (1.05, 0.5), 
        xycoords  = ax[1].transAxes, 
        bbox      = dict(boxstyle="round", fc="w"),
        family    = "monospace"
    )
    
    # Plot residuals
    if residuals:
        ax[1].vlines(  
            df.index, 
            label      =  "residual",
            ymin       =  df['y'], 
            ymax       =  df['y_hat'], 
            linestyles =  "dashed", color="red"
        )
    
    # General plot handling
    ### FYI:
    ### dict(param1 = "value1", param2 = "value2") == {"param1":"value1", "param2":"value2}
    
    # R2 Plot
    df.plot(kind="scatter", x="y", y="y_hat", ax=ax[0])
    
    plot_params = dict(ax = ax[1], stacked = False)
    
    if kind == "line":
        
        # Plot observations # on x-axis 
        df['obs'] = df.index

        # plot_scores(perfect, kind="area")
        y_scatter = df.plot(kind="scatter", x="obs", y="y", s=75, ax=ax[1], label="y")
        df.plot(kind="scatter", x="obs", y="y_hat", s=90, color="orange", label="y_hat", ax=y_scatter)
        legend()
        
    else:
        plot_params.update(dict(
            kind  = "scatter",
            x     = "y",
            y     = "y_hat",
            xlim  = [20, 100],
            alpha = .75
        ))
        df[['y', 'y_hat']].plot(**plot_params)