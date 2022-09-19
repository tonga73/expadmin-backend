import { Module } from '@nestjs/common';
import { CourtsService } from './courts.service';
import { CourtsController } from './courts.controller';

import { PrismaService } from '../prisma.service';

@Module({
  controllers: [CourtsController],
  providers: [CourtsService, PrismaService],
  exports: [CourtsService],
})
export class CourtsModule {}
