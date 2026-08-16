import React, { useState } from 'react';
import { ImageOff, Sparkles } from 'lucide-react';

interface SafeImageProps {
  src: string;
  alt: string;
  className?: string;
  containerClassName?: string;
  fallbackIcon?: React.ReactNode;
}

export const SafeImage: React.FC<SafeImageProps> = ({
  src,
  alt,
  className = 'h-full w-full object-cover',
  containerClassName = 'relative w-full h-full overflow-hidden bg-slate-100 dark:bg-slate-800',
  fallbackIcon,
}) => {
  const [hasError, setHasError] = useState(false);
  const [isLoaded, setIsLoaded] = useState(false);

  return (
    <div className={containerClassName}>
      {!hasError ? (
        <>
          <img
            src={src}
            alt={alt}
            referrerPolicy="no-referrer"
            loading="lazy"
            onLoad={() => setIsLoaded(true)}
            onError={() => setHasError(true)}
            className={`${className} transition-opacity duration-300 ${
              isLoaded ? 'opacity-100' : 'opacity-0'
            }`}
          />
          {!isLoaded && (
            <div className="absolute inset-0 bg-slate-200 dark:bg-slate-800 animate-pulse flex items-center justify-center">
              <Sparkles className="h-6 w-6 text-slate-400 dark:text-slate-600 animate-spin" />
            </div>
          )}
        </>
      ) : (
        <div className="absolute inset-0 bg-gradient-to-br from-[#0B192C] to-[#1E3E62] flex flex-col items-center justify-center p-4 text-center">
          {fallbackIcon || <Sparkles className="h-8 w-8 text-[#00D4FF] mb-1 opacity-75" />}
          <span className="text-[11px] font-semibold text-slate-300 line-clamp-1 max-w-[90%]">
            {alt}
          </span>
        </div>
      )}
    </div>
  );
};
