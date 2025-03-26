# Imports
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from scipy.stats import percentileofscore
from typing import Dict, Tuple, List, Optional, Any
import os
import stouputils as stp


# Functions
@stp.decorators.measure_time()
def load_data(file_path: str) -> pd.DataFrame:
    """Load and prepare player data from CSV file.
    
    Args:
        file_path (str): Path to the CSV file containing player data.
    
    Returns:
        pd.DataFrame: Prepared dataframe with player data.
    """
    # Load data
    df = pd.read_csv(file_path)
    
    # Convert timestamps to datetime
    df['registered'] = pd.to_datetime(df['registered'], unit='ms')
    
    # Convert string 'NULL' to actual null values
    df = df.replace('NULL', np.nan)
    
    # Convert numeric columns
    numeric_cols = ['times_kicked', 'nb_player_kills', 'nb_mob_kills', 'nb_deaths', 
                    'avg_ping', 'nb_sessions', 'longest_session', 'avg_session',
                    'active_playtime', 'afk_time']
    
    for col in numeric_cols:
        if col in df.columns:
            df[col] = pd.to_numeric(df[col], errors='coerce')
    
    # Calculate additional metrics
    df['total_kills'] = df['nb_player_kills'] + df['nb_mob_kills']
    df['kd_ratio'] = df['total_kills'] / df['nb_deaths'].replace(0, 1)  # Avoid division by zero
    
    # Convert time metrics from milliseconds to hours
    time_cols = ['longest_session', 'avg_session', 'active_playtime', 'afk_time']
    for col in time_cols:
        if col in df.columns:
            df[f'{col}_hours'] = df[col] / (1000 * 60 * 60)
    
    # Calculate AFK percentage
    df['afk_percentage'] = (df['afk_time'] / (df['active_playtime'] + df['afk_time'])) * 100
    
    return df

@stp.decorators.measure_time()
def basic_statistics(df: pd.DataFrame) -> Dict[str, Any]:
    """Calculate basic statistics for the dataset.
    
    Args:
        df (pd.DataFrame): Player data dataframe.
    
    Returns:
        Dict[str, Any]: Dictionary containing various statistics.
    """
    stats = {}
    
    # Total players
    stats['total_players'] = len(df)
    
    # Active players (with at least 5 sessions)
    active_players = df[df['nb_sessions'] >= 5]
    stats['active_players'] = len(active_players)
    
    # Players by country
    country_counts = df['geolocation'].value_counts().to_dict()
    stats['players_by_country'] = country_counts
    
    # Total playtime in hours
    total_playtime = df['active_playtime_hours'].sum()
    stats['total_playtime_hours'] = total_playtime
    
    # Average session length
    stats['avg_session_length_hours'] = df['avg_session_hours'].mean()
    
    # Total kills, deaths
    stats['total_player_kills'] = df['nb_player_kills'].sum()
    stats['total_mob_kills'] = df['nb_mob_kills'].sum()
    stats['total_deaths'] = df['nb_deaths'].sum()
    
    # Average K/D ratio
    stats['avg_kd_ratio'] = df['kd_ratio'].mean()
    
    # Favorite worlds
    favorite_worlds = df['favorite_world'].value_counts().to_dict()
    stats['favorite_worlds'] = favorite_worlds
    
    return stats

@stp.decorators.measure_time()
def player_engagement_analysis(df: pd.DataFrame) -> Dict[str, float]:
    """Analyze player engagement metrics.
    
    Args:
        df (pd.DataFrame): Player data dataframe.
    
    Returns:
        Dict[str, float]: Dictionary containing engagement metrics.
    """
    engagement = {}
    
    # Average sessions per player
    engagement['avg_sessions_per_player'] = df['nb_sessions'].mean()
    
    # Average playtime per player
    engagement['avg_playtime_hours_per_player'] = df['active_playtime_hours'].mean()
    
    # Average AFK percentage
    engagement['avg_afk_percentage'] = df['afk_percentage'].mean()
    
    # Average kicks per player
    engagement['avg_kicks_per_player'] = df['times_kicked'].mean()
    
    # Correlation between playtime and sessions
    engagement['playtime_sessions_correlation'] = df['active_playtime_hours'].corr(df['nb_sessions'])
    
    # Player retention (players who have logged in more than once)
    engagement['player_retention'] = len(df[df['nb_sessions'] > 1]) / len(df) * 100
    
    return engagement

@stp.decorators.measure_time()
@stp.decorators.handle_error(error_log=stp.decorators.LogLevels.WARNING_TRACEBACK)
def visualize_player_stats(df: pd.DataFrame, output_dir: str) -> None:
    """Create visualizations of player statistics.
    
    Args:
        df (pd.DataFrame): Player data dataframe.
        output_dir (str): Directory to save visualization files.
    
    Returns:
        None
    """
    # Create output directory if it doesn't exist
    os.makedirs(output_dir, exist_ok=True)
    
    # Set the style for all visualizations
    plt.style.use('ggplot')
    sns.set_palette("viridis")
    
    # 1. Distribution of playtime
    plt.figure(figsize=(12, 6))
    sns.histplot(df['active_playtime_hours'], bins=30, kde=True)
    plt.title('Distribution of Player Playtime')
    plt.xlabel('Playtime (hours)')
    plt.ylabel('Number of Players')
    plt.tight_layout()
    plt.savefig(f"{output_dir}/playtime_distribution.png")
    plt.close()
    
    # 2. Top 20 players by playtime
    top_playtime = df.sort_values('active_playtime_hours', ascending=False).head(20)
    plt.figure(figsize=(14, 8))
    sns.barplot(x='active_playtime_hours', y='name', data=top_playtime)
    plt.title('Top 20 Players by Playtime')
    plt.xlabel('Playtime (hours)')
    plt.ylabel('Player')
    plt.tight_layout()
    plt.savefig(f"{output_dir}/top_players_playtime.png")
    plt.close()
    
    # 3. Correlation heatmap
    plt.figure(figsize=(12, 10))
    correlation_columns = [
        'nb_player_kills', 'nb_mob_kills', 'nb_deaths', 'avg_ping', 
        'nb_sessions', 'active_playtime_hours', 'afk_time_hours', 'afk_percentage'
    ]
    corr_matrix = df[correlation_columns].corr()
    mask = np.triu(np.ones_like(corr_matrix, dtype=bool))
    sns.heatmap(corr_matrix, annot=True, fmt=".2f", mask=mask, cmap='coolwarm', vmin=-1, vmax=1)
    plt.title('Correlation Between Player Metrics')
    plt.tight_layout()
    plt.savefig(f"{output_dir}/correlation_heatmap.png")
    plt.close()
    
    # 4. K/D Ratio vs Playtime scatter plot
    plt.figure(figsize=(10, 6))
    sns.scatterplot(x='active_playtime_hours', y='kd_ratio', data=df, alpha=0.6, hue='nb_sessions')
    plt.title('K/D Ratio vs Playtime')
    plt.xlabel('Playtime (hours)')
    plt.ylabel('K/D Ratio')
    plt.ylim(0, min(10, df['kd_ratio'].max()))  # Limit y-axis for better visualization
    plt.tight_layout()
    plt.savefig(f"{output_dir}/kd_vs_playtime.png")
    plt.close()
    
    # 5. Favorite worlds distribution
    world_counts = df['favorite_world'].value_counts().reset_index()
    world_counts.columns = ['world', 'count']
    top_worlds = world_counts.head(10)
    
    plt.figure(figsize=(12, 6))
    sns.barplot(x='count', y='world', data=top_worlds)
    plt.title('Top 10 Favorite Worlds')
    plt.xlabel('Number of Players')
    plt.ylabel('World')
    plt.tight_layout()
    plt.savefig(f"{output_dir}/favorite_worlds.png")
    plt.close()
    
    # 6. Geolocation distribution
    geo_counts = df['geolocation'].value_counts().reset_index()
    geo_counts.columns = ['country', 'count']
    
    plt.figure(figsize=(12, 6))
    sns.barplot(x='count', y='country', data=geo_counts)
    plt.title('Player Distribution by Country')
    plt.xlabel('Number of Players')
    plt.ylabel('Country')
    plt.tight_layout()
    plt.savefig(f"{output_dir}/player_countries.png")
    plt.close()
    
    # 7. Registration timeline
    plt.figure(figsize=(14, 6))
    df['registered'].dt.date.value_counts().sort_index().plot()
    plt.title('Player Registrations Over Time')
    plt.xlabel('Date')
    plt.ylabel('Number of New Players')
    plt.tight_layout()
    plt.savefig(f"{output_dir}/registration_timeline.png")
    plt.close()

@stp.decorators.measure_time()
@stp.decorators.handle_error(error_log=stp.decorators.LogLevels.WARNING_TRACEBACK)
def player_clustering(df: pd.DataFrame) -> Tuple[pd.DataFrame, plt.Figure]:
    """Cluster players based on their behavior using K-means.
    
    Args:
        df               (pd.DataFrame):      Player data dataframe.
    
    Returns:
        Tuple[pd.DataFrame, plt.Figure]: Cluster assignments and visualization.
    """
    from sklearn.cluster import KMeans
    from sklearn.preprocessing import StandardScaler
    from sklearn.decomposition import PCA
    
    # Select features for clustering
    features = ['nb_player_kills', 'nb_mob_kills', 'nb_deaths', 
                'active_playtime_hours', 'afk_percentage', 'nb_sessions']
    
    # Only include players with enough data - make an explicit copy
    cluster_df = df.dropna(subset=features).copy()
    
    # Standardize features
    scaler = StandardScaler()
    scaled_features = scaler.fit_transform(cluster_df[features])
    
    # Determine optimal number of clusters
    inertia = []
    for k in range(1, 11):
        kmeans = KMeans(n_clusters=k, random_state=42)
        kmeans.fit(scaled_features)
        inertia.append(kmeans.inertia_)
    
    # Apply K-means with the chosen number of clusters (4 seems reasonable)
    kmeans = KMeans(n_clusters=4, random_state=42)
    cluster_labels = kmeans.fit_predict(scaled_features)
    
    # Add cluster labels to dataframe using loc to avoid warning
    cluster_df.loc[:, 'cluster'] = cluster_labels
    
    # Apply PCA for visualization
    pca = PCA(n_components=2)
    principal_components = pca.fit_transform(scaled_features)
    
    # Create PCA dataframe
    pca_df = pd.DataFrame(data=principal_components, columns=['PC1', 'PC2'])
    pca_df['cluster'] = cluster_labels
    pca_df['name'] = cluster_df['name'].values
    
    # Visualize clusters
    fig, ax = plt.subplots(figsize=(12, 8))
    
    for cluster in pca_df['cluster'].unique():
        cluster_data = pca_df[pca_df['cluster'] == cluster]
        ax.scatter(cluster_data['PC1'], cluster_data['PC2'], label=f'Cluster {cluster}', alpha=0.7)
    
    ax.set_title('Player Clusters Based on Behavior')
    ax.set_xlabel('Principal Component 1')
    ax.set_ylabel('Principal Component 2')
    ax.legend()
    
    # Analyze cluster characteristics
    cluster_analysis = cluster_df.groupby('cluster')[features].mean()
    
    return cluster_analysis, fig

@stp.decorators.measure_time()
def analyze_player_evolution(df: pd.DataFrame) -> Dict[str, pd.DataFrame]:
    """Analyze how player base has evolved over time.
    
    Args:
        df (pd.DataFrame): Player data dataframe.
    
    Returns:
        Dict[str, pd.DataFrame]: Dictionary with evolution analysis dataframes.
    """
    # Create a copy with registration date only
    df_copy = df.copy()
    df_copy['registration_date'] = df_copy['registered'].dt.date
    
    # Group by registration year and month
    df_copy['registration_year_month'] = df_copy['registered'].dt.to_period('M')
    
    # Monthly new player counts
    monthly_registrations = df_copy.groupby('registration_year_month').size()
    
    # Calculate cumulative players over time
    cumulative_players = monthly_registrations.cumsum()
    
    # Average playtime by registration cohort
    avg_playtime_by_cohort = df_copy.groupby('registration_year_month')['active_playtime_hours'].mean()
    
    # Average sessions by registration cohort
    avg_sessions_by_cohort = df_copy.groupby('registration_year_month')['nb_sessions'].mean()
    
    return {
        'monthly_registrations': monthly_registrations.reset_index(),
        'cumulative_players': cumulative_players.reset_index(),
        'avg_playtime_by_cohort': avg_playtime_by_cohort.reset_index(),
        'avg_sessions_by_cohort': avg_sessions_by_cohort.reset_index()
    }

@stp.decorators.simple_cache()
def generate_player_report(df: pd.DataFrame, player_name: str) -> Dict[str, Any]:
    """Generate a detailed report for a specific player.
    
    Args:
        df (pd.DataFrame): Player data dataframe.
        player_name (str): Name of the player to analyze.
    
    Returns:
        Dict[str, Any]: Dictionary containing player statistics.
    """
    if player_name not in df['name'].values:
        stp.print.warning(f"Player {player_name} not found in the dataset")
        return {"error": f"Player {player_name} not found in the dataset"}
    
    player_data = df[df['name'] == player_name].iloc[0]
    
    # Calculate percentiles
    playtime_percentile = percentileofscore(df['active_playtime_hours'], player_data['active_playtime_hours'])
    kills_percentile = percentileofscore(df['total_kills'], player_data['total_kills'])
    sessions_percentile = percentileofscore(df['nb_sessions'], player_data['nb_sessions'])
    
    report = {
        "name": player_name,
        "registered_date": player_data['registered'],
        "playtime_hours": player_data['active_playtime_hours'],
        "playtime_percentile": playtime_percentile,
        "total_sessions": player_data['nb_sessions'],
        "sessions_percentile": sessions_percentile,
        "avg_session_hours": player_data['avg_session_hours'],
        "player_kills": player_data['nb_player_kills'],
        "mob_kills": player_data['nb_mob_kills'],
        "total_kills": player_data['total_kills'],
        "kills_percentile": kills_percentile,
        "deaths": player_data['nb_deaths'],
        "kd_ratio": player_data['kd_ratio'],
        "times_kicked": player_data['times_kicked'],
        "favorite_world": player_data['favorite_world'],
        "afk_percentage": player_data['afk_percentage']
    }
    
    return report

@stp.decorators.measure_time()
def process_visualizations(df: pd.DataFrame, output_dir: str) -> None:
    """Process all visualizations in parallel.

    Args:
        df               (pd.DataFrame):      Player data dataframe.
        output_dir       (str):               Directory to save visualization files.
    
    Returns:
        None
    """
    # Define functions to create individual plots
    def create_playtime_distribution():
        plt.figure(figsize=(12, 6))
        sns.histplot(df['active_playtime_hours'], bins=30, kde=True)
        plt.title('Distribution of Player Playtime')
        plt.xlabel('Playtime (hours)')
        plt.ylabel('Number of Players')
        plt.tight_layout()
        plt.savefig(f"{output_dir}/playtime_distribution.png")
        plt.close()
        return "Playtime distribution created"
    
    def create_top_players():
        top_playtime = df.sort_values('active_playtime_hours', ascending=False).head(20)
        plt.figure(figsize=(14, 8))
        sns.barplot(x='active_playtime_hours', y='name', data=top_playtime)
        plt.title('Top 20 Players by Playtime')
        plt.xlabel('Playtime (hours)')
        plt.ylabel('Player')
        plt.tight_layout()
        plt.savefig(f"{output_dir}/top_players_playtime.png")
        plt.close()
        return "Top players plot created"
    
    def create_correlation_heatmap():
        plt.figure(figsize=(12, 10))
        correlation_columns = [
            'nb_player_kills', 'nb_mob_kills', 'nb_deaths', 'avg_ping', 
            'nb_sessions', 'active_playtime_hours', 'afk_time_hours', 'afk_percentage'
        ]
        corr_matrix = df[correlation_columns].corr()
        mask = np.triu(np.ones_like(corr_matrix, dtype=bool))
        sns.heatmap(corr_matrix, annot=True, fmt=".2f", mask=mask, cmap='coolwarm', vmin=-1, vmax=1)
        plt.title('Correlation Between Player Metrics')
        plt.tight_layout()
        plt.savefig(f"{output_dir}/correlation_heatmap.png")
        plt.close()
        return "Correlation heatmap created"
    
    funcs = [create_playtime_distribution, create_top_players, create_correlation_heatmap]
    results = [f() for f in funcs]
    
    for result in results:
        stp.print.info(result)

def convert_to_serializable(obj: Any) -> Any:
    """Convert numpy and other non-serializable types to python native types.

    Args:
        obj              (Any):              Object to convert.
    
    Returns:
        Any:              Serializable version of the object.
    """
    # Handle numpy scalars
    if isinstance(obj, np.integer):
        return int(obj)
    elif isinstance(obj, np.floating):
        return float(obj)
    elif isinstance(obj, np.ndarray):
        return obj.tolist()
    # Handle pandas Period type
    elif hasattr(obj, 'strftime'):
        return str(obj)
    # Handle dictionaries
    elif isinstance(obj, dict):
        return {k: convert_to_serializable(v) for k, v in obj.items()}
    # Handle lists and tuples
    elif isinstance(obj, (list, tuple)):
        return [convert_to_serializable(item) for item in obj]
    # Return unchanged if no conversion needed
    return obj

def save_data_to_json(data: Dict, filename: str, output_dir: str) -> None:
    """Save data to a JSON file using stouputils.

    Args:
        data             (Dict):              Data to save.
        filename         (str):               Name of the file.
        output_dir       (str):               Directory to save the file.
    
    Returns:
        None
    """
    filepath = os.path.join(output_dir, filename)
    
    # Convert non-serializable types to serializable ones
    serializable_data = convert_to_serializable(data)
    
    # Since we're consistently hitting an error with super_json_dump, let's use
    # the fallback method directly for reliability
    import json
    try:
        with open(filepath, 'w') as f:
            json.dump(serializable_data, f, indent=4)
        stp.print.info(f"Saved data to {filepath}")
    except Exception as e:
        stp.print.error(f"Failed to save {filename}: {str(e)}")

@stp.decorators.measure_time()
def main() -> None:
    """Main function to run the analysis."""
    # Set paths
    current_dir = os.path.dirname(os.path.abspath(__file__))
    data_path = os.path.join(current_dir, 'plan_users.csv')
    output_dir = os.path.join(current_dir, 'analytics_output')
    
    # Create output directory if it doesn't exist
    os.makedirs(output_dir, exist_ok=True)
    
    # Set up logging to file
    log_file = os.path.join(output_dir, 'analytics.log')
    
    with stp.ctx.LogToFile(log_file):
        try:
            # Load data
            stp.print.info("Loading and processing data...")
            df = load_data(data_path)
            
            # Run analyses
            stp.print.info("Running basic statistics...")
            stats = basic_statistics(df)
            
            stp.print.info("Analyzing player engagement...")
            engagement = player_engagement_analysis(df)
            
            # Save statistics and engagement data to JSON files
            save_data_to_json(stats, "basic_statistics.json", output_dir)
            save_data_to_json(engagement, "player_engagement.json", output_dir)
            
            # Process visualizations in parallel
            stp.print.info("Creating visualizations in parallel...")
            process_visualizations(df, output_dir)
            
            # Additional visualizations that might be more complex
            stp.print.info("Creating standard visualizations...")
            visualize_player_stats(df, output_dir)
            
            stp.print.info("Clustering players...")
            cluster_analysis, cluster_fig = player_clustering(df)
            cluster_fig.savefig(f"{output_dir}/player_clusters.png")
            plt.close(cluster_fig)
            
            stp.print.info("Analyzing player evolution...")
            evolution = analyze_player_evolution(df)
            
            # Example for generating a specific player report
            player_name = "Stoupy51"  # Example player, can be changed
            if player_name in df['name'].values:
                stp.print.info(f"Generating report for player: {player_name}")
                player_report = generate_player_report(df, player_name)
                save_data_to_json(player_report, f"player_report_{player_name}.json", output_dir)
            
            # Save analyses results to CSV
            cluster_analysis.to_csv(f"{output_dir}/player_clusters_analysis.csv")
            
            # Save evolution data
            for key, data in evolution.items():
                data.to_csv(f"{output_dir}/{key}.csv", index=False)
            
            stp.print.info(f"Analysis complete. Results saved to {output_dir}")
            
            # Display some key statistics
            stp.print.info("\nSummary Statistics:")
            stp.print.info(f"Total Players: {stats['total_players']}")
            stp.print.info(f"Active Players: {stats['active_players']}")
            stp.print.info(f"Average Playtime per Player: {engagement['avg_playtime_hours_per_player']:.2f} hours")
            stp.print.info(f"Average Sessions per Player: {engagement['avg_sessions_per_player']:.2f}")
            stp.print.info(f"Player Retention Rate: {engagement['player_retention']:.2f}%")
            stp.print.info(f"Most Popular World: {max(stats['favorite_worlds'], key=stats['favorite_worlds'].get)}")
            
        except Exception as e:
            stp.print.error(f"An error occurred during analysis: {str(e)}")
            raise

if __name__ == "__main__":
    main()

